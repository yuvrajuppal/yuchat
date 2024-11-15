import 'package:flutter/material.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  State<BottomNavigationBarCustom> createState() => _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  List<Widget> navicons = [
    Container(child: Icon(Icons.abc, size: 10)),
    Container(width: 1, height: 10, decoration: BoxDecoration(color: Colors.black)),
    Container(child: Icon(Icons.abc, size: 10)),
    Container(width: 1, height: 10, decoration: BoxDecoration(color: Colors.black)),
    Container(child: Icon(Icons.abc, size: 10)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 7),
          height: 80,
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 148, 32, 24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              navicons.length,
              (index) => SizedBox(
                // width: 80,
                child: Center(child: navicons[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
