import 'package:flutter/material.dart';

class StoredPage extends StatefulWidget {
  StoredPage({this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _StoredPageState();
  }
}

class _StoredPageState extends State<StoredPage> {
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
          child: Text('Another text'),
        ),
      ),
    );
  }
}
