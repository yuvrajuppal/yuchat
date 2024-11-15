import 'package:flutter/material.dart';
import 'package:yuchat/pages/chatpage.dart';
import 'package:yuchat/pages/emailverification.dart';
import 'package:yuchat/pages/homepage.dart';
import 'package:yuchat/pages/loginpage.dart';
import 'package:yuchat/pages/navifgator2.0.dart';
import 'package:yuchat/pages/navigationbar%20copy.dart';
import 'package:yuchat/pages/navigationbar.dart';
import 'package:yuchat/pages/signuppage.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: signuppage(),
    );
  }
}
