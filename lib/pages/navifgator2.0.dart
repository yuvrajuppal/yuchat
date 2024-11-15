import 'package:flutter/material.dart';
import 'package:yuchat/pages/homepage.dart';
import 'package:yuchat/pages/search.dart';
import 'package:yuchat/pages/homepage.dart';
import 'package:yuchat/pages/profilepage.dart';

class BottomNavigationBarWithSwipe extends StatefulWidget {
  const BottomNavigationBarWithSwipe({super.key});

  @override
  State<BottomNavigationBarWithSwipe> createState() => _BottomNavigationBarWithSwipeState();
}

class _BottomNavigationBarWithSwipeState extends State<BottomNavigationBarWithSwipe> {
  late PageController _pageController;
  late List<Widget> pages;
  late searchpage searchpagenav;
  late homepage home;
  late prifilepage profile;

  int currentpageindex = 0;

  @override
  void initState() {
    super.initState();
    home = homepage();
    searchpagenav = searchpage();
    profile = prifilepage();
    pages = [home, searchpagenav, profile];
    _pageController = PageController(initialPage: currentpageindex);
  }

  // List<IconData> navicons = [Icons.home_filled, Icons.people_alt, Icons.person];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> navwidger = [
      GestureDetector(
          onTap: () {
            _onTapNavItem(0);
          },
          child: Container(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 10, top: 10),
              child: Icon(Icons.home_filled, size: 30))),
      Container(
          width: 1,
          height: 39,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 198, 198, 198),
          )),
      GestureDetector(
          onTap: () {
            _onTapNavItem(1);
          },
          child: Container(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 10, top: 10),
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
            _onTapNavItem(2);
          },
          child: Container(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 10, top: 10),
              child: Icon(Icons.person, size: 30))),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  navwidger.length,
                  (index) => GestureDetector(
                        onTap: () {
                          _onTapNavItem(index);
                        },
                        child: navwidger[index],
                      ))),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            currentpageindex = index;
          });
        },
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }

  void _onTapNavItem(int index) {
    setState(() {
      currentpageindex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
