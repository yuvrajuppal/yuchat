import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuchat/services/myproviderclass.dart';
import 'package:yuchat/services/shared_pref.dart';

class MyWidget001 extends StatefulWidget {
  const MyWidget001({super.key});

  @override
  State<MyWidget001> createState() => _MyWidget001State();
}

class _MyWidget001State extends State<MyWidget001> {



  List<String>? homeusers;

  getproviderassign() {

    homeusers = Provider.of<myproviderclass>(context, listen: false).allusername;
        
    print(homeusers);

  }


  calladderfinttion(){
        Provider.of<myproviderclass>(context, listen: false).addhomeuser('ypypy');
SharedprefHelper().saveStringList(homeusers!);

  }

deletealluser(){
      Provider.of<myproviderclass>(context, listen: false).allusername = [];
      homeusers=[];
SharedprefHelper().saveStringList(homeusers!);

}


ontheload()async{

   homeusers = await  SharedprefHelper().getStringList();
  Provider.of<myproviderclass>(context, listen: false).allusername = homeusers!;
}


@override
  void initState() {
    ontheload();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            
            Center(
              child: 
              GestureDetector(
                onTap: (){
                  print('hello');
                  getproviderassign();
                },
                child: Text('hello'),
              ),
            ),
            SizedBox(height: 30,),
               Center(
              child: 
              GestureDetector(
                onTap: (){
                  print('hello');
                 calladderfinttion();
                },
                child: Text('hello'),
              ),
            )
            ,  SizedBox(height: 30,),
               Center(
              child: 
              GestureDetector(
                onTap: (){
                  print('hello');
                 deletealluser();
                },
                child: Text('hello'),
              ),
            )
         
       
        ],
      ),
    );
  }
}
