

import 'package:flutter/material.dart';
int counter=0;
class ChooseLocation extends StatefulWidget {

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('choose a location') ,
        centerTitle: true,
        elevation: 60,
      ),
      body:Container
        (
        child: Column
          (
          children: <Widget>
          [

          ],
        ),
      )

    );
  }
}
