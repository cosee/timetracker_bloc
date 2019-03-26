import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  EditPage({this.title});
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
