import 'package:flutter/material.dart';


class WedProfile extends StatefulWidget {
  const WedProfile({Key? key}) : super(key: key);

  @override
  State<WedProfile> createState() => _WedProfileState();
}

class _WedProfileState extends State<WedProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        centerTitle: true,
title: Text("Edit Profile"),
      ),
    );
  }
}










