import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Screens/Home/Mobilepages/MchatSearch.dart';
import 'package:forum3/Screens/Home/Mobilepages/MmChatScreen.dart';
import 'package:forum3/shared/Widgets/Chatheadcard.dart';
import 'package:provider/provider.dart';

import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';

class Mmessages extends StatefulWidget {
  const Mmessages({Key? key}) : super(key: key);

  @override
  State<Mmessages> createState() => _MmessagesState();
}

class _MmessagesState extends State<Mmessages> {
  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;

    return user1.Guest==true? const Scaffold(
      body: SafeArea(
        child: Center(
child: Text(
    "Access Denied",
style: TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
),
),
        ),
      ),
    ): Scaffold(
body: StreamBuilder(
  stream: FirebaseFirestore.instance.collection('Chats').doc(user1.UID).collection("Chathead").orderBy("Chat Time",descending: true).snapshots(),
  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
    if(snapshot.connectionState==ConnectionState.waiting){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>MmchatScreen(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                )
            );
          },
          child: CHcard(
            snap: snapshot.data!.docs[index].data(),
          ),
        )
    );
  },
),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context)=>Mchatusersearch(),
              )
          );
        },
      child: const FaIcon(
          FontAwesomeIcons.searchengin,
      ),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
