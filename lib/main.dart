import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yuchat/pages/chatpage.dart';
import 'package:yuchat/pages/checksharepref.dart';
import 'package:yuchat/pages/emailverification.dart';
import 'package:yuchat/pages/forgetpassword.dart';
import 'package:yuchat/pages/homepage.dart';
import 'package:yuchat/pages/homeyuchat.dart';
import 'package:yuchat/pages/loginpage.dart';
import 'package:yuchat/pages/navifgator2.0.dart';
import 'package:yuchat/pages/navigationbar%20copy.dart';
import 'package:yuchat/pages/navigationbar.dart';
import 'package:yuchat/pages/prefchecker.dart';
import 'package:yuchat/pages/profilepage.dart';
import 'package:yuchat/pages/search.dart';
// import 'package:yuchat/pages/search%20copy.dart';
import 'package:yuchat/pages/signuppage.dart';
import 'package:yuchat/services/database.dart';

import 'package:yuchat/services/myproviderclass.dart';
import 'package:provider/provider.dart';
import 'package:yuchat/services/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => myproviderclass(),
    child: authcker(),
  ));
}

class authcker extends StatefulWidget {
  const authcker({super.key});

  @override
  State<authcker> createState() => _authckerState();
}

class _authckerState extends State<authcker> {
  String? svaedid;
  bool? auther;
  bool isloading = true;

  Future<void> getsavedinfo() async {
    svaedid = await SharedprefHelper().getuserid();

    // auther = await DatabaseMethods().checkIfIdExists(svaedid!);
    if (svaedid != null) {
      auther = await DatabaseMethods().checkIfIdExists(svaedid!);
    } else {
      auther = false;
    }
    print("Saved ID: $svaedid");
    print("Authentication status: $auther");

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsavedinfo();
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
          child: CircularProgressIndicator(),
        ),
        )
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auther! ? bottomnavigationbar() : loginpage(),
    );
  }
}
