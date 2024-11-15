import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yuchat/pages/chatpage.dart';
import 'package:yuchat/pages/user_profile.dart';
import 'package:yuchat/services/database.dart';
import 'package:yuchat/services/shared_pref.dart';
import 'package:provider/provider.dart';
import 'package:yuchat/services/myproviderclass.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  bool search = false;
  String name = "";
  String? myname, myprofilepic, myusername, myemail;
  List<String>? homeusers;

  getthesharedprefhere() async {
    myname = await SharedprefHelper().getusername();
    myemail = await SharedprefHelper().getuserEmail();
    myprofilepic = await SharedprefHelper().getuserImage();
    myusername = await SharedprefHelper().getuser_username();
  }

  getchatrooomidbyusername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  ontheload() async {

List<String>? templist = await SharedprefHelper().getStringList();  
  Provider.of<myproviderclass>(context, listen: false).allusername = templist!;
homeusers = Provider.of<myproviderclass>(context, listen: false).allusername;


    await getthesharedprefhere();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ontheload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xffC6C6C6)),
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(top: 70),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            name = val;
                            if (name == "" || name.isEmpty) {
                              search = false;
                            } else {
                              search = true;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(Icons.search_sharp)),
                  ],
                ),
              ),
              Expanded(
                child: search
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .snapshots(),
                        builder: (context, snaphsots) {
                          return (snaphsots.connectionState ==
                                  ConnectionState.waiting)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: snaphsots.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var data = snaphsots.data!.docs[index]
                                        .data() as Map<String, dynamic>;
                                    if (name.isEmpty || name == "") {
                                      return BuildresultCart(data);
                                    }
                                    if (data["Name"]
                                        .toString()
                                        .startsWith(name.toLowerCase())) {
                                      return BuildresultCart(data);
                                    }
                                    return Container();
                                  });
                        },
                      )
                    : Container(),
              ),
            ],
          ),
        ));
  }

  Widget BuildresultCart(data) {
    return GestureDetector(
      onTap: () async {
        var chatRoomid =
            getchatrooomidbyusername(myusername!, data["username"]);
        Map<String, dynamic> chatroominfomap = {
          "users": [myusername, data["username"]]
        };
        print('id = ' + data["Id"]);
        print('name = ' + data["Name"]);
        print('email = ' + data["Mail"]);
        print('@username = ' + data["username"]);
        print('imageurl = ' + data["image"]);

        await DatabaseMethods().createchatroom(chatRoomid, chatroominfomap);
        // await SharedprefHelper().savehomeuser(data["username"]);
        Provider.of<myproviderclass>(context, listen: false).addhomeuser(data["username"]);
        homeusers =         Provider.of<myproviderclass>(context, listen: false).allusername;
        await SharedprefHelper().saveStringList(homeusers!);
        Provider.of<myproviderclass>(context, listen: false).homepagesbool=true;


        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => chatpage(
                      id: data["Id"],
                      image: data["image"],
                      mail: data["Mail"],
                      name: data["Name"],
                      username: data["username"],
                      chatroomid: chatRoomid,
                    )));
      },
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  data["image"],
                  width: 80,
                  fit: BoxFit.cover,
                  height: 80,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  // color: Colors.yellow,
                  ),
              width: MediaQuery.of(context).size.width / 1.5,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '9:00 PM',
                        style: TextStyle(
                            // fontSize: 16,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(data["username"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      'Hello, What are you doing',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
