import 'package:flutter/material.dart';

class user_profile extends StatefulWidget {
  const user_profile({super.key});

  @override
  State<user_profile> createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('user profilepage')),
    );
  }
}