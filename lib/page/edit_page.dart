import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:time_track/page/drawer/main_drawer.dart';
import 'package:time_track/widgets/edit_row.dart';
import 'package:time_track/model/work_day.dart';
import 'package:time_track/model/work_period.dart';
import 'package:time_track/widgets/times_editor.dart';
import 'package:time_track/widgets/centered_loading_spinner.dart';
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
  bool resetTimesEditor = false;

  WorkDay _getSelected() => period.workDays[selectedIndex];
  WorkPeriod period = WorkPeriod.dummyList();

  @override
  void initState() {
    print('selected index: $selectedIndex');
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
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(accentColor: Colors.blue),
        home: Scaffold(
          drawer: MainDrawer(context),
          appBar: AppBar(title: Text(widget.title)),
          body: _dbLoaded
              ? _createTable()
              : CenteredLoadingSpinner(text: 'Loading stored times...'),
        ));
  }

  _createTable() => Column(
        children: <Widget>[
          _createTableHead(),
          Flexible(
            flex: 5,
            child: _buildTimesList(),
          ),
          _createTimesEditor(),
        ],
      );

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
    Widget timesList = Center(child: Text("No Times persisted yet"));

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

  Widget _createTimesEditor() {
    print('building timesEditor');
    var tmp = TimesEditor(
      work: _getSelected(),
      index: selectedIndex,
      clearButtonEnabled: _getSelected().isEnabled(),
      saveChanges: _saveChanges,
      clearEntry: _clearEntry,
      resetState: resetTimesEditor,
    );

    setState(() => resetTimesEditor = false);
    return tmp;
  }

  void _selectDay(int index) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    setState(() {
      resetTimesEditor = true;
      selectedIndex = index;
    });
  }

  void _clearEntry(int idx) {
    setState(() {
      period.workDays[idx].hoursWorked = 0;
      resetTimesEditor = true;
      WorkDayDb().insert(period.workDays[idx]).then((onValue) {
        print('db reponse $onValue');
      });
    });
  }

  //Finds indext of date
  void _saveChanges(WorkDay day) => setState(() {
        int index = period.workDays.indexWhere((item) {
          return item.date.year == day.date.year &&
              item.date.month == day.date.month &&
              item.date.day == day.date.day;
        });

        period.workDays[index] = day.clone();

        WorkDayDb().insert(period.workDays[index]).then((onValue) {
          print('db reponse $onValue');
        });

        _selectDay(index); //AFTER changing the values!
        print('saveChanges idx $index');
      });
}
