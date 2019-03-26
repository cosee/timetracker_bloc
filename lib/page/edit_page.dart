import 'package:flutter/material.dart';

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
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text('Drawer'),
                automaticallyImplyLeading: false,
              ),
              ListTile(
                title: Text('Edit work times'),
                onTap: () => Navigator.pushReplacementNamed(context, '/'),
              ),
              ListTile(
                title: Text('Stored work times'),
                onTap: () => Navigator.pushReplacementNamed(context, '/stored'),
              )
            ],
          ),
        ),
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
