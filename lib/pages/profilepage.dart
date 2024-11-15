import 'package:flutter/material.dart';
import 'package:yuchat/pages/loginpage.dart';
import 'package:yuchat/services/shared_pref.dart';
class prifilepage extends StatefulWidget {
  const prifilepage({super.key});

  @override
  State<prifilepage> createState() => _prifilepage();
}

class _prifilepage extends State<prifilepage> {

String? email,image,name,username,displayemail;
String usernamedisplay = "";

getsjaredpref()async{
name = await SharedprefHelper().getusername();
email = await SharedprefHelper().getuserEmail();
image = await SharedprefHelper().getuserImage();
username  = await SharedprefHelper().getuser_username();
usernamedisplay = username.toString();
displayemail  = email!.substring(0,7);
setState(() {
  
});
}

@override
  void initState() {
    getsjaredpref();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 80, left: 20),
              child: Text(
                'hy,$name',
                style: TextStyle(fontSize: 27, fontFamily: 'mako'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Stack(
              // alignment: Alignment(x, y),
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 00),
                      child: Container(
                        width: 180,
                        height: 180,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
        "https://img.freepik.com/premium-vector/man-profile-cartoon_18591-58482.jpg?w=360",                            
        
        
        width: 180,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$name',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'mako',
                              color: Colors.black),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: Text(
                            displayemail!,
                            style: TextStyle(
                                fontFamily: 'mako',
                                fontSize: 13,
                                color: Colors.black),
                          ),
                        ),
                        Text('$username',
                            style: TextStyle(
                                fontFamily: 'mako',
                                fontSize: 13,
                                color: Color(0xFF888888))),
                      ],
                    )
                  ],
                ),
                Positioned(
                  bottom: 10,
                  left: 140,
                  child: GestureDetector(
                    onTap: (){
                      print(name);
                      print(email);
                      print(image);
                      print(username);
                      print(usernamedisplay);
                      
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 4, left: 4),
                      width: 96,
                      height: 28,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFC6C6C6),
                            width: 1,
                          ),
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Edit Profile ',
                            style: TextStyle(fontFamily: 'mako', fontSize: 11),
                          ),
                          // SizedBox(width: 6,),
                          Icon(
                            Icons.edit,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: GestureDetector(
                onTap: (){
                  print(email!);
                },
                child: Text(
                  'Setting',
                  style: TextStyle(fontSize: 31),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        // margin: EdgeInsets.only(left: 14),
                        width: 47,
                        height: 47,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Icon(
                          Icons.person_outlined,
                          size: 45,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Account',
                    style: TextStyle(fontFamily: 'mako', fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        // margin: EdgeInsets.only(left: 14),
                        width: 47,
                        height: 47,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Icon(
                          Icons.lock_rounded,
                          size: 45,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Privacy',
                    style: TextStyle(fontFamily: 'mako', fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        // margin: EdgeInsets.only(left: 14),
                        width: 47,
                        height: 47,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Icon(
                          Icons.palette,
                          size: 45,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Theme',
                    style: TextStyle(fontFamily: 'mako', fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        // margin: EdgeInsets.only(left: 14),
                        width: 47,
                        height: 47,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Icon(
                          Icons.notifications,
                          size: 45,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Notification',
                    style: TextStyle(fontFamily: 'mako', fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        // margin: EdgeInsets.only(left: 14),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Icon(
                          Icons.info_rounded,
                          size: 47,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Account',
                    style: TextStyle(fontFamily: 'mako', fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
             GestureDetector(
              onTap: (){
                SharedprefHelper().clearAll();
                print('all local data cleared');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>loginpage()));
              },
               child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          // margin: EdgeInsets.only(left: 14),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Icon(
                            Icons.logout,
                            size: 47,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'logout',
                      style: TextStyle(fontFamily: 'mako', fontSize: 18),
                    )
                  ],
                ),
                           ),
             ),
            SizedBox( height: 20,),
             Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      // margin: EdgeInsets.only(left: 14),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Icon(
                        Icons.info_rounded,
                        size: 47,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Delete Account',
                  style: TextStyle(fontFamily: 'mako', fontSize: 18),
                )
              ],
            ),
          ),
        
          
          ],
        ),
      ),
    );
  }
}
