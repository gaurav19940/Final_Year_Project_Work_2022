import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:forum3/shared/Widgets/Messagecard.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';

class mChatbody extends StatefulWidget {
  final snap;
  const mChatbody({Key? key,this.snap}) : super(key: key);

  @override
  State<mChatbody> createState() => _mChatbodyState();
}

class _mChatbodyState extends State<mChatbody> {

  _options(BuildContext context,String author,String author_uid,String receiver, String receiver_uid,String message_uid)async{
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text(
              "More options",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(15.0),
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: ()async{
                  String ress=await FirestoreMethods().Deletemessage(author, author_uid, receiver, receiver_uid, message_uid);
                  Showsnackbar(ress, context);
                  Navigator.of(context).pop();
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Chats').doc(user1.UID).collection("Chathead").doc(widget.snap['Receiver uid']).collection('message').orderBy("Message Time").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    user1.UID!=snapshot.data!.docs[index].data()['Receiver Uid']?  Expanded(
                        child: SizedBox()
                    ):SizedBox(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: SizedBox(
                        child: GestureDetector(
                          onLongPress: (){
                            if(snapshot.data!.docs[index].data()['author uid']==user1.UID){
                           _options(context, snapshot.data!.docs[index].data()['author'], user1.UID!, snapshot.data!.docs[index].data()['Receiver'], snapshot.data!.docs[index].data()['Receiver Uid'], snapshot.data!.docs[index].data()['Message Uid']);
                            }else{
                              Showsnackbar("Access Denied", context);
                            }
                          },
                          child: chatcard(
                            snap: snapshot.data!.docs[index].data(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }
}
