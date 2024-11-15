import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:yuchat/services/database.dart';
import 'package:yuchat/services/shared_pref.dart';

class chatpage extends StatefulWidget {
  final String id, mail, name, username, image;
  final String chatroomid;
  chatpage({
    required this.id,
    required this.mail,
    required this.name,
    required this.username,
    required this.image,
    required this.chatroomid,
  });
  
  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  TextEditingController messageController = TextEditingController();
  String? myname, myemail, myimage, myusername;
  String? friendUserImage;
  Stream? messageStream;

  @override
  void initState() {
    super.initState();
    onload();
  }

  Future<void> onload() async {
    await getSharedPref();
    await getAndSetMessage();
  }

  Future<void> getSharedPref() async {
    myname = await SharedprefHelper().getusername();
    myemail = await SharedprefHelper().getuserEmail();
    myimage = await SharedprefHelper().getuserImage();
    myusername = await SharedprefHelper().getuser_username();
    friendUserImage = widget.image.trim();

    setState(() {}); // Ensure UI reflects updated information
  }

  Future<void> getAndSetMessage() async {
    messageStream = await DatabaseMethods().getchatroommessage(widget.chatroomid);
    setState(() {});
  }

  Widget chatMessage() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 90, top: 130),
                itemCount: snapshot.data.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return chatMessageTile(ds["message"], myusername == ds["sendby"]);
                })
            : Container(child: Text('No data'));
      },
    );
  }

  Widget chatMessageTile(String message, bool sentByMe) {
    return Row(
      mainAxisAlignment: sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          alignment: sentByMe ? Alignment.bottomRight : Alignment.bottomLeft,
          width: MediaQuery.of(context).size.width / 2,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(message),
          ),
        ),
      ],
    );
  }

  void addMessage(bool sendClicked) {
    if (messageController.text.trim() != "") {
      String message = messageController.text;
      messageController.clear();
      String formattedData = DateFormat('h:mma').format(DateTime.now());

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendby": myusername,
        "ts": formattedData,
        "time": FieldValue.serverTimestamp(),
        "imageurl": myimage,
      };

      String messageId = randomAlphaNumeric(10);
      DatabaseMethods().addmessage(widget.chatroomid, messageId, messageInfoMap).then(
        (value) {
          Map<String, dynamic> lastMessageInfoMap = {
            "lastmessage": message,
            "lastmessagesendts": formattedData,
            "time": FieldValue.serverTimestamp(),
            "lastmessagesendby": myusername,
          };
          DatabaseMethods().updatelastmessagesend(widget.chatroomid, lastMessageInfoMap);
        },
      );
    }
  }

  TextStyle popupTextStyle = TextStyle(fontFamily: 'mako', fontSize: 13, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: 80.0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                "images/samirimage.png",
                width: 80,
                fit: BoxFit.cover,
                height: 80,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'mako'),
                ),
                Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: Colors.grey),
                    Text(
                      'last seen 13hr ago',
                      style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'mako'),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton(
            color: Color(0xFFF2F2F2),
            icon: Icon(Icons.more_vert),
            offset: Offset(-30, 0),
            position: PopupMenuPosition.under,
            onSelected: (value) => print(value),
            itemBuilder: (context) => [
              PopupMenuItem(value: 'report', child: Text('Report', style: popupTextStyle)),
              PopupMenuItem(value: 'Block', child: Text('Block', style: popupTextStyle)),
              PopupMenuItem(value: 'Search', child: Text('Search', style: popupTextStyle)),
              PopupMenuItem(value: 'mute_notification', child: Text('Mute Notification', style: popupTextStyle)),
              PopupMenuItem(value: 'medialinksdocs', child: Text('Media, links & Docs', style: popupTextStyle)),
              PopupMenuItem(value: 'Clear_chat', child: Text('Clear Chat', style: popupTextStyle)),
            ],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: chatMessage()),
          Container(
            height: 55,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              border: Border.all(color: Color(0xFFC6C6C6)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Image.asset('icons/LOL.png'),
                SizedBox(width: 3),
                Icon(Icons.attach_file, size: 30),
                VerticalDivider(width: 7, thickness: 1, color: Colors.black),
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => addMessage(true),
                  child: Icon(Icons.send_sharp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
