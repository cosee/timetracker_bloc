import 'package:flutter/material.dart';

import 'package:time_track/page/drawer/main_drawer.dart';
import 'package:time_track/widgets/edit_row.dart';
import 'package:time_track/model/work_day.dart';
import 'package:time_track/model/work_period.dart';


class EditPage extends StatefulWidget {
  EditPage({this.title = 'Edit Page'});
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _EditPageState();
  }
}

class _EditPageState extends State<EditPage> {
    int selectedIndex = 0;
  WorkDay dayCache;
  WorkPeriod period;

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
          child: EditRow()
        ),
      ),
    );
  }
}
