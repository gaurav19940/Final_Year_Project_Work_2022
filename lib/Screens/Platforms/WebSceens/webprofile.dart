import 'package:flutter/material.dart';

class Wprofile extends StatefulWidget {
  const Wprofile({Key? key}) : super(key: key);

  @override
  State<Wprofile> createState() => _WprofileState();
}

class _WprofileState extends State<Wprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("Pofile"),
),
      body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[

                ],
              ),
            ),
          )
      ),
    );
  }
}
