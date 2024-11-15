// import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SharedprefHelper {
  static String userIdkey = "idkey";
  static String usernamekey = "namekey";
  static String userimagekey = "imagekey";
  static String useremailkey = "mailkey";
  static String user_usernamekey="user";



  Future<bool> saveuserid(String getuserid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userIdkey, getuserid);
  }

  Future<bool> saveusername(String getusername) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(usernamekey, getusername);
  }

  Future<bool> saveuseremail(String getuseremail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(useremailkey, getuseremail);
  }

  Future<bool> saveuserimage(String getuserimage) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(userimagekey, getuserimage);
  }


Future<bool> saveUser_username(String getuser_username)async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString(user_usernamekey, getuser_username);
}






  Future<String?> getusername()async{
    SharedPreferences pref =  await SharedPreferences.getInstance();
    return pref.getString(usernamekey);
  }
   Future<String?> getuserEmail()async{
    SharedPreferences pref =  await SharedPreferences.getInstance();
    return pref.getString(useremailkey);
  }
  Future<String?> getuserImage()async{
    SharedPreferences pref =  await SharedPreferences.getInstance();
    return pref.getString(userimagekey);
  }
    Future<String?> getuserid()async{
    SharedPreferences pref =  await SharedPreferences.getInstance();
    return pref.getString(userIdkey);
  }

  Future<String?> getuser_username()async{
    SharedPreferences pref =  await SharedPreferences.getInstance();
    return pref.getString(user_usernamekey);
  }





Future<void> saveStringList(List<String> items) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('my_string_list', items);
}

Future<List<String>?> getStringList() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  
  return prefs.getStringList('my_string_list');
}


 Future<void> clearAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    print("All SharedPreferences data cleared!");
  }
}
