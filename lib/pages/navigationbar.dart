import 'package:flutter/material.dart';
import 'package:yuchat/pages/homepage.dart';
import 'package:yuchat/pages/search.dart';
import 'package:yuchat/pages/homepage.dart';
import 'package:yuchat/pages/profilepage.dart';

class bottomnavigationbar extends StatefulWidget {
  const bottomnavigationbar({super.key});

  @override
  State<bottomnavigationbar> createState() => _bottomnavigationbarState();
}

class _bottomnavigationbarState extends State<bottomnavigationbar> {
  late List<Widget> pages;
  late searchpage searchpagenav;
  late homepage home;
  late prifilepage profile;

  int currentpageindex = 0;
  void initState() {
    home = homepage();
    searchpagenav = searchpage();
    profile = prifilepage();
    pages = [home, searchpagenav, profile];
    super.initState();
  }

  // List<IconData> navicons = [Icons.abc, Icons.abc, Icons.abc];

  @override
  Widget build(BuildContext context) {
    List<Widget> navwidger = [
      GestureDetector(
          onTap: () {
            setState(() {
              currentpageindex = 0;
            });
          },
          child: Container(
              // width: 50,
              // padding: ,
              // decoration: BoxDecoration(color: Colors.grey),
              padding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 10, top: 10),
              child: Icon(Icons.home_filled, size: 30))),
      Container(
          width: 1,
          height: 39,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 198, 198, 198),
          )),
      GestureDetector(
          onTap: () {
            setState(() {
              currentpageindex = 1;
            });
          },
          child: Container(
              // width: 50,
              // padding: ,
              // decoration: BoxDecoration(color: Colors.grey),
              padding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 10, top: 10),
              child: Icon(Icons.people_alt, size: 30))),
      Container(
        width: 1,
        height: 39,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 198, 198, 198),
        ),
      ),
      GestureDetector(
          onTap: () {
            setState(() {
              currentpageindex = 2;
            });
          },
          child: Container(
              // width: 50,
              // padding: ,
              // decoration: BoxDecoration(color: Colors.grey),
              padding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 10, top: 10),
              child: Icon(Icons.person, size: 30))),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  navwidger.length,
                  (index) => Container(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentpageindex = index;
                              });
                              print(index);
                            },
                            child: navwidger[index]),
                      ))),
        ),
      ),
      body: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (child, animation){
            return FadeTransition(opacity: animation, child: child,);
          },
          child: pages[currentpageindex],

      ),


      
    );
  }
}
