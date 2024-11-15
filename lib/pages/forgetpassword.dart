import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forgetpasswordpage extends StatefulWidget {
  const forgetpasswordpage({super.key});

  @override
  State<forgetpasswordpage> createState() => _forgetpasswordpageState();
}

class _forgetpasswordpageState extends State<forgetpasswordpage> {
  TextEditingController email_controller = new TextEditingController();
  String Email = "";

  final _formkey = GlobalKey<FormState>();

  resetpasswod() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: Email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('email sended'),
        ),
      );
      print("mail sended");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // height: 300,
                  // width: 500,
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      ),
                  // clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'images/applogo.png',
                    fit: BoxFit.cover,
                    // width: 300,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Forget Password',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'mako',
                        fontWeight: FontWeight.w400),
                  ),
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
                          child: Icon(Icons.lock_open),
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
                        controller: email_controller,
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
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if(_formkey.currentState!.validate()){
                      print(email_controller.text);
                      setState(() {
                        Email=email_controller.text.trim();
                      });
                      resetpasswod();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      border: Border.all(
                        color: Color(0xFFDBDBDB),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 230,
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Send Email',
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
                SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text('Go back to login'))
              
              ],
            ),
          ),
        ));
  }
}
