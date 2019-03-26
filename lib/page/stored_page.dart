import 'package:flutter/material.dart';

import 'package:time_track/page/drawer/main_drawer.dart';

class StoredPage extends StatefulWidget {
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
        drawer: MainDrawer(context, StoredPage),
        appBar: AppBar(
          title: Text('Useless page rigth now'),
        ),
        body: Center(
          child: Text('Another text'),
        ),
      ),
    );
  }
}
