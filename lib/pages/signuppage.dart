import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_string/random_string.dart';
import 'package:yuchat/pages/emailverification.dart';
import 'package:yuchat/pages/homepage.dart';
import 'package:yuchat/pages/navigationbar.dart';
import 'package:yuchat/services/database.dart';
import 'package:yuchat/services/shared_pref.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppage();
}

class _signuppage extends State<signuppage> {
  // List<String> allhomeusers = [];
  IconData passicon = Icons.visibility_off;

  String? mail, password, name, confirmpassword;
  TextEditingController mail_controller = new TextEditingController();
  TextEditingController name_controller = new TextEditingController();
  TextEditingController password_controller = new TextEditingController();
  TextEditingController confirmopassword_controller = new TextEditingController();
  TextEditingController username_controller = new TextEditingController();
  bool eye = true;

  final _formkey = GlobalKey<FormState>();

Future<bool> isUsernameAvailable(String username) async {


  final query = await FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: username)
      .get();
    


  return query.docs.isEmpty; 
}


  registration() async {
     bool isAvailable = await isUsernameAvailable(username_controller.text.trim());
   if(!isAvailable)
   {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username already taken. Please choose another')));
   } 

    else if (password_controller.text.trim() !=
        confirmopassword_controller.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("password and confirm password is not same")));
    } else if (mail != null ||
        name != null ||
        password != null ||
        confirmpassword != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);
        String id = randomAlphaNumeric(10);
        Map<String, dynamic> userinfomap = {
          "Name": name_controller.text.trim(),
          "Mail": mail_controller.text.trim(),
          "image":
              "https://img.freepik.com/premium-vector/man-profile-cartoon_18591-58482.jpg?w=360",
          "Id": id,
          "username":username_controller.text.trim(),
          "password":password_controller.text.trim(),
        };
        // userCredential.user?.emailVerified

        await SharedprefHelper().saveuseremail(mail_controller.text.trim());
        await SharedprefHelper().saveusername(name_controller.text.trim());
        await SharedprefHelper().saveuserid(id);
        await SharedprefHelper().saveuserimage(
            "https://img.freepik.com/premium-vector/man-profile-cartoon_18591-58482.jpg?w=360s");
        await SharedprefHelper().saveUser_username(username_controller.text.trim());
       
         List<String> allhomeusers = [];

        await SharedprefHelper().saveStringList(allhomeusers);



        await DatabaseMethods().addUserdetail(userinfomap, id);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => bottomnavigationbar()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Registed successfully'),
          ),
        );
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

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
                'Create account',
                style: TextStyle(
                  fontFamily: 'mako',
                  fontSize: 24,
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
                        child: Icon(Icons.email),
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else {
                          return null;
                        }
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
                    
                        decoration: BoxDecoration(
          
                            ),
                        child: Icon(Icons.person_4),
                
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Username';
                        } else {
                          return null;
                        }
                      },
                      controller: username_controller,
                      decoration: InputDecoration(
                          hintText: "User Name",
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
                        // padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            // color: Colors.black,
                            // borderRadius: BorderRadius.circular(100),
                            ),
                        child: Icon(Icons.person),
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        } else {
                          return null;
                        }
                      },
                      controller: name_controller,
                      decoration: InputDecoration(
                          hintText: "Name",
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
                      obscureText: eye,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        } else {
                          return null;
                        }
                      },
                      controller: password_controller,
                      decoration: InputDecoration(
                          hintText: "Pasword",
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
                              eye = false;

                              passicon = Icons.remove_red_eye;
                            } else {
                              eye = true;
                              passicon = Icons.visibility_off;
                            }
                          });
                        },
                        child: Icon(passicon)),
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
                      obscureText: eye,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Confirm password';
                        } else {
                          return null;
                        }
                      },
                      controller: confirmopassword_controller,
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
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
                              eye = false;
                              passicon = Icons.remove_red_eye;
                            } else {
                              eye = true;
                              passicon = Icons.visibility_off;
                            }
                          });
                        },
                        child: Icon(passicon)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    print(mail_controller.text.trim());
                    print(password_controller.text.trim());
                    setState(() {
                      name = name_controller.text.trim();
                      mail = mail_controller.text.trim();
                      password = password_controller.text.trim();
                      confirmpassword = confirmopassword_controller.text.trim();
                    });
                    registration();
                  }
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
                      EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(fontFamily: 'mako', fontSize: 17),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                        color: Color.fromRGBO(136, 136, 136, 1.0),
                        fontSize: 14.0),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
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
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
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
                    EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
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
