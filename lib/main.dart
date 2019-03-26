import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    title: 'Tolle App',
  ));
}

class MyApp extends StatefulWidget {
  MyApp({this.title});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
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
              setState(() {
                //ATOMIC OPERATION -> will store state even if app is already moving to background
                buttonText = 'No Button at all!';
              });
            },
          ),
        ),
      ),
    );
  }
}
