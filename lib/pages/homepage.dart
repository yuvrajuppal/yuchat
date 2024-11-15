import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuchat/pages/chatpage.dart';
import 'package:yuchat/services/database.dart';
import 'package:yuchat/services/myproviderclass.dart';
import 'package:yuchat/services/shared_pref.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  Stream? chatroomstream;
  String? myusername;


  getchatrooomidbyusername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

 Future<void> getSharedPref() async {
   
    myusername = await SharedprefHelper().getuser_username();

    setState(() {}); // Ensure UI reflects updated information
  }
ontheload()async{
   homepagestarterteller=Provider.of<myproviderclass>(context, listen: false).homepagesbool;

await getSharedPref();
chatroomstream = await DatabaseMethods().getchatrooms();
usernames =  await  SharedprefHelper().getStringList();
print(homepagestarterteller);
setState(() {
  
});
}
  List<String>? usernames;
  bool homepagestarterteller = false;
@override
  void initState() {
    //  print(usernames!.length);
    // TODO: implement initState
    // homepagestarter();
    super.initState();
    ontheload();
  }

 
homepagestarter(){
  if (usernames!.isEmpty){
    homepagestarterteller = true;
  }
  else{
      homepagestarterteller = false;
  }
}


  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    Widget chatroomslist() {
      return homepagestarterteller ? StreamBuilder(

          stream: chatroomstream,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap:  true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.doc.length;

return chatroomlisttile(chatroomid: ds.id,lastmessage: ds["lastmessage"], myusername: myusername!, time: ds["lastmessagesendts"],);

                  })
                : Container();
          }):Container();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Yu Chat',
                        style: TextStyle(
                            fontSize: 25,
                            // fontWeight: FontWeight.bold,
                            fontFamily: 'mako'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: Icon(
                        Icons.search_sharp,
                        size: 25,
                      ),
                    ),
                    Icon(Icons.more_vert)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: homepagestarterteller! ? StreamBuilder(
        stream:
            usersCollection.where('username', whereIn: usernames).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var data = documents[index];
                var username = data['username'] ?? 'N/A';
                String imageurl = data['image'];
                return GestureDetector(
                  onTap: ()async{
                    print('tap on $username');
                    



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
                              "$imageurl",
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
                              Text("$username",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  'update coming soom',
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
              });
        },
      ):Container(),
                      
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class chatroomlisttile extends StatefulWidget {
  final String lastmessage,chatroomid,myusername,time;
  chatroomlisttile({required this.lastmessage, required  this.chatroomid, required this.myusername, required this.time});

  @override
  State<chatroomlisttile> createState() => _chatroomlisttileState();
}

class _chatroomlisttileState extends State<chatroomlisttile> {

  String profilepicurl="", name="",username="", id = "";
  getthisuserinfo()async{
    username =  widget.chatroomid.replaceAll("_","").replaceAll(widget.myusername,"");
      QuerySnapshot data =  await DatabaseMethods().getuserbyusername(username);
  name =  "${data.docs[0]["Name"]}";
  username = "${data.docs[0]["username"]}";
  id = "${data.docs[0]["Id"]}";
  profilepicurl = "${data.docs[0]["image"]}";
  setState(() {
    
  });
  }

  // QuerySnapshot queerysnapshot =  await 
@override
  void initState() {
    getthisuserinfo();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Text(name),
    );
  }
}