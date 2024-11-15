import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yuchat/pages/checksharepref.dart';
import 'package:yuchat/pages/forgetpassword.dart';
import 'package:yuchat/pages/navigationbar.dart';
import 'package:yuchat/pages/prefchecker.dart';
import 'package:yuchat/pages/signuppage.dart';
import 'package:yuchat/services/database.dart';
import 'package:yuchat/services/shared_pref.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  String mail = "", password = "";
  TextEditingController mail_controller = new TextEditingController();
  TextEditingController password_controller = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  userlogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      // Navigator.push(MaterialPageRoute(builder: (context)=> bottomnavigationbar()));

      String? shName, shMail, shImage, shId, shUserName;
      QuerySnapshot? data;
      data = await DatabaseMethods().getuserdata(mail);

      shName = "${data!.docs[0]["Name"]}";
      shMail = "${data!.docs[0]["Mail"]}";
      shImage = "${data!.docs[0]["image"]}";
      shId = "${data!.docs[0]["Id"]}";
      shUserName = "${data!.docs[0]["username"]}";

      shName = shName.toString().trim();
      shMail = shMail.toString().trim();
      shImage = shImage.toString().trim();
      shId = shId.toString().trim();
      shUserName = shUserName.toString().trim();

      print(shName);
      print(shMail);
      print(shImage);
      print(shId);
      print(shUserName);

      await SharedprefHelper().saveusername(shName);
      await SharedprefHelper().saveuseremail(shMail);
      await SharedprefHelper().saveuserid(shId);
      await SharedprefHelper().saveuserimage(shImage);
      await SharedprefHelper().saveUser_username(shUserName);
      List<String> allhomeusers = [];
      await SharedprefHelper().saveStringList(allhomeusers);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => bottomnavigationbar()));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  IconData passicon = Icons.remove_red_eye;

  // IconData lockicon =
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Image.asset(
                  'images/applogo.png',
                  color: Colors.black,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'mako',
                  fontSize: 35,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  border: Border.all(
                    color: Color(0xFFDBDBDB),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width / 1.15,
                padding:
                    EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      child: Container(
                          width: 30,
                          // padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              // color: Colors.black,
                              // borderRadius: BorderRadius.circular(100),
                              ),
                          child: Icon(Icons.person)

                          // Icon(
                          //   Icons.lock,
                          //   color: Color(0xFFF2F2F2),
                          //   size: 24,
                          // )
                          ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      decoration: BoxDecoration(
                        color: Color(0xFFDBDBDB),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextFormField(
                      validator: (value) {
                        if (value == "") {
                          return 'mail not entered';
                        }
                        return null;
                      },
                      controller: mail_controller,
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontFamily: 'mako',
                          ),
                          border: InputBorder.none),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  border: Border.all(
                    color: Color(0xFFDBDBDB),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width / 1.15,
                padding:
                    EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      child: Container(
                          width: 30,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.lock,
                            color: Color(0xFFF2F2F2),
                            size: 22,
                          )),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      decoration: BoxDecoration(
                        color: Color(0xFFDBDBDB),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextFormField(
                      validator: (value) {
                        if (value == "") {
                          return 'mail not entered';
                        }
                        return null;
                      },
                      controller: password_controller,
                      decoration: InputDecoration(
                          hintText: "password",
                          hintStyle: TextStyle(
                            fontFamily: 'mako',
                          ),
                          border: InputBorder.none),

                      // 'password',
                      // style: TextStyle(
                      //   fontFamily: 'mako',
                      // ),
                    )),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (passicon == Icons.visibility_off) {
                              passicon = Icons.remove_red_eye;
                            } else {
                              passicon = Icons.visibility_off;
                            }
                          });
                        },
                        child: Icon(passicon)),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => forgetpasswordpage(),
                              ),
                            );
                          },
                          child: Text(
                            'Forget password ?',
                            style: TextStyle(
                              fontFamily: 'mako',
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    mail = mail_controller.text.trim();
                    password = password_controller.text.toString();
                  });
                  userlogin();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    border: Border.all(
                      color: Color(0xFFDBDBDB),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 220,
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(fontFamily: 'mako', fontSize: 22),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(Icons.login_rounded),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have account? ',
                    style: TextStyle(
                        color: Color.fromRGBO(136, 136, 136, 1.0),
                        fontSize: 14.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => signuppage(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  border: Border.all(
                    color: Color(0xFFDBDBDB),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                width: 280,
                padding:
                    EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: 30,
                      child: FaIcon(
                        FontAwesomeIcons.google, // Google's "G" icon
                        size: 25.0,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      decoration: BoxDecoration(
                        color: Color(0xFFDBDBDB),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Continui with google',
                          style: TextStyle(
                              fontFamily: 'mako',
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  border: Border.all(
                    color: Color(0xFFDBDBDB),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                width: 280,
                padding:
                    EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      width: 30,
                      child: FaIcon(
                        FontAwesomeIcons.apple, // Google's "G" icon
                        size: 30.0,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      height: 40,
                      width: 2,
                      decoration: BoxDecoration(
                        color: Color(0xFFDBDBDB),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Continui with google',
                          style: TextStyle(
                              fontFamily: 'mako',
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
