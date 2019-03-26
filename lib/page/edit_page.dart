import 'package:flutter/material.dart';

import 'package:time_track/page/drawer/main_drawer.dart';
import 'package:time_track/widgets/edit_row.dart';
import 'package:time_track/model/work_day.dart';
import 'package:time_track/model/work_period.dart';
import 'package:time_track/db/entities/work_day_db.dart';

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
  bool _dbLoaded = false;
  WorkDay dayCache;
  WorkPeriod period = WorkPeriod.dummyList();

  @override
  void initState() {
    print('selected index: $selectedIndex');
    _initDayCache();
    _loadDates();
    super.initState();
  }

  void _loadDates() {
    WorkDayDb().getAll().then((workDays) {
      setState(() {
        if (workDays.isNotEmpty) {
          period = WorkPeriod(
              periodBegin: DateTime.now(),
              periodEnd: DateTime.now().add(Duration(days: 30)),
              workDays: workDays);
        } else {
          period = WorkPeriod(
              periodBegin: DateTime.now(),
              periodEnd: DateTime.now().add(Duration(days: 30)));
        }
        _initDayCache();
        _dbLoaded = true;
      });
    });
  }

  void _initDayCache() {
    if (period?.workDays?.isNotEmpty == true) {
      dayCache = period.workDays[selectedIndex].clone();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: Colors.blue),
      home: Scaffold(
        drawer: MainDrawer(context),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _dbLoaded
            ? Column(
                children: <Widget>[
                  _createTableHead(),
                  Flexible(
                    flex: 5,
                    child: _buildTimesList(),
                  ),
                ],
              )
            : Center(child: Text('No times stored yet!')),
      ),
    );
  }

  _createTableHead() => Container(
        margin: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 70,
              child: Text('Weekday'),
            ),
            Container(
              width: 80,
              child: Text('Date'),
            ),
            Container(
              width: 50,
              child: Text('Begin'),
            ),
            Container(
              width: 100,
              child: Text('Hours worked'),
            ),
          ],
        ),
      );

  Widget _buildTimesList() {
    Widget timesList = Center(
      child: Text("No Times persisted yet"),
    );
    print('building list!');
    if (period.workDays.length > 0) {
      timesList = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: period.workDays.length,
      );
    }

    return timesList;
  }

  Widget _buildProductItem(BuildContext context, int index) => EditRow(
        workEntry: period.workDays[index],
        index: index,
        selectDay: _selectDay,
        isSelected: selectedIndex == index,
      );

  void _selectDay(int index) => setState(() {
        selectedIndex = index;
        dayCache = period.workDays[index].clone();
        print(dayCache.date.toString());
      });
}
