import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Emailverification extends StatefulWidget {
  const Emailverification({super.key});

  @override
  State<Emailverification> createState() => _Emailverification();
}

class _Emailverification extends State<Emailverification> {
  IconData passicon = Icons.remove_red_eye;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            'Email Verification',
            style: TextStyle(
              fontFamily: 'mako',
              fontSize: 24,
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
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
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
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          fontFamily: 'mako',
                        ),
                        border: InputBorder.none),
                    // 'password',
                    // style: TextStyle(
                    //   fontFamily: 'mako',
                    // ),
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
              borderRadius: BorderRadius.circular(20),
            ),
            width: 220,
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
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
           SizedBox(
            height: 250,
          ),
           
        ],
      ),
    );
  }
}

class Base64ImageIcon extends StatelessWidget {
  // Your Base64 string (shortened here for clarity)
  final String base64String =
      "iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAACXBIWXMAAAsTAAALEwEAmpwYAAABS0lEQVR4nO2WQUoDUQyGvwvoQnChtuI5RA9Q0aKIh1DbehZ3irpx6b7qTTriTk9g684pSiCFoThJ5k0rLvpBNg/++SeZJG9gwT9kE+gCz0AGfGpketYBmrM03ACugRz4dmIMPABbdU0PgVHAcDqGQDvV9EIzqGpazL6Xkum4hmnRPJx5I7G8VtnXI8Z3zoPegGNgSeNIO9vS3ERGJndMV37Rydm7ocu1kqV0nTeXTIU9NZJo6dmJoz23jJ8csZSWqeykCsKyo+1bxq+OeEL0vBiZZTw0hNv47DjdXYo1RlHK9B+W6GWOxoPU5qpr3LdEnTkan1qiprFApHE8dku0X94CEW6dsUiJq+jFb41V1ZBuXiNIK/jHEbkWD6KmE3oz+BGQ3Z9EO7HsUt59arIKXGpnRrK8r/JNIzT0anvULTTSGOhyOIuMzAL+mh/4IG6QjR9viwAAAABJRU5ErkJggg==";

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(
      bytes,
    );
  }
}
