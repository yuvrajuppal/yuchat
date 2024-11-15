import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class myproviderclass extends ChangeNotifier {
  List<String> allusername = [];
  bool homepagesbool = false;
  void addhomeuser(username) {
      if(allusername.contains(username)){
          print('already have in homelist');
      }
      else{
    allusername.add(username);

      }


    notifyListeners();
  }
}
