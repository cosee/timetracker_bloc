import 'package:flutter/material.dart';

import 'package:time_track/page/drawer/main_drawer.dart';

class EditPage extends StatefulWidget {
  EditPage({this.title = 'Edit Page'});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _EditPageState();
  }
}

class _EditPageState extends State<EditPage> {
  String buttonText = 'Button!';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: Colors.blue),
      home: Scaffold(
        drawer: MainDrawer(context),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: RaisedButton(
            child: Text(buttonText),
            onPressed: () {
              // buttonText = 'No Button at all!';
              setState(() {
                buttonText = 'No Button at all!';
              });
            },
          ),
        ),
      ),
    );
  }
}