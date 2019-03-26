import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    title: 'Tolle App',
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.title});
  final String title;
  String buttonText = 'Button!';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: RaisedButton(
            child: Text(buttonText),
            onPressed: () {
              buttonText = 'No Button at all!';
            },
          ),
        ),
      ),
    );
  }
}
