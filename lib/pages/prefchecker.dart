import 'package:flutter/material.dart';
import 'package:yuchat/services/shared_pref.dart';

class helloworld extends StatefulWidget {
  const helloworld({super.key});

  @override
  State<helloworld> createState() => _helloworldState();
}

class _helloworldState extends State<helloworld> {
  String? email, image, name, id;

  getsjaredpref() async {
    name = await SharedprefHelper().getusername();
    email = await SharedprefHelper().getuserEmail();
    image = await SharedprefHelper().getuserImage();
    id = await SharedprefHelper().getuserid();
    print(email);
    print(name);
    print(id);
    print(image);

  }



setsharepref()async{
  await SharedprefHelper().saveusername("yuvraj");
await SharedprefHelper().saveuseremail("hello@gmail.com");
await SharedprefHelper().saveuserid("id number 1101");
await SharedprefHelper().saveuserimage("imagelink");
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              child: GestureDetector(
                  onTap: () {
                    getsjaredpref();
                    // print(email);
                  },
                  child: Text('print me')),
            ),
            SizedBox(height: 30,),
            Container(
              child: GestureDetector(
                  onTap: () {
                    setsharepref();
                    // print(email);
                  },
                  child: Text('click me',style: TextStyle(fontSize: 30),)),
            ),
          ],
        ),
      ),
    );
  }
}
