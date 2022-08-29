import 'package:flutter/material.dart';

class NotifCard extends StatefulWidget {
  final snap;
  const NotifCard({Key? key,this.snap}) : super(key: key);

  @override
  State<NotifCard> createState() => _NotifCardState();
}

class _NotifCardState extends State<NotifCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(

      ),
      child:  Card(
        elevation: 2.0,
        child: Row(
          children: [
            CircleAvatar(
backgroundColor: Colors.lightBlueAccent,
             // backgroundImage: NetworkImage(widget.snap['Profile Pic']),
            ),
            Text(
              widget.snap['author'],
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(),
            Text(
              widget.snap['message'],
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
