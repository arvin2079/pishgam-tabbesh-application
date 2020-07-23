import 'package:flutter/material.dart';
import 'package:practice/choose_location.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      body: SafeArea
        (
        child:Column
          (
          children: <Widget>
          [
            FlatButton.icon
              (
                onPressed: ()
                {
                  Navigator.pushNamed(context, '/loacation');
                }
                , icon: Icon(Icons.edit_location)
                , label: Text('Edit Location')
            )
          ],
        )

      ),
    );
  }
}
