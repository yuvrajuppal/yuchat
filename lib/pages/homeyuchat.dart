import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class homeyuchat extends StatefulWidget {
  const homeyuchat({super.key});

  @override
  State<homeyuchat> createState() => _homeyuchatState();
}

class _homeyuchatState extends State<homeyuchat> {
  final List<String> usernames = ["ramram", "lassi singh", "yuvraj8570"];

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
                var user = documents[index];
                var username = user['username'] ?? 'N/A';
                String imageurl = user['image'];
                return Container(
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
                );
              });
        },
      ),
    );
  }
}
