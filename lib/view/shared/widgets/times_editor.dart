import 'package:flutter/material.dart';
import 'package:time_track/shared/blocs/main/blocs.dart';

import 'package:time_track/shared/helper/formatter.dart';
import 'package:time_track/view/shared/widgets/drop_down_button.dart';
import 'package:time_track/model/work_day.dart';

class TimesEditor extends StatelessWidget {
  TimesEditor({
    this.work,
    this.index,
    this.clearButtonEnabled,
    this.saveChanges,
    this.clearEntry,
    // this.resetState,
  }) {
    dayCache = this.work;
  }

  final WorkDayState work;
  final int index;
  final bool clearButtonEnabled;
  // bool resetState; //FIXME: This is BS. BLoC pattern should solve these issues.
  final Function(WorkDayState) saveChanges;
  final Function(int) clearEntry;

  // @override
  // State<StatefulWidget> createState() {
  //   print('CREATE of _TimesEditorState');
  //   return _TimesEditorState();
  // }

  TextEditingController controller;
  WorkDayState dayCache;

  void _cacheDateTime(DateTime time)  {}
  // setState(() {
  //     //   dayCache.date = DateTime(time.year, time.month, time.day,
  //     //       dayCache.date.hour, dayCache.date.minute);
  //     });

  void _cacheDayTime(TimeOfDay time) {}
  // => setState(() {
  //       // print('hours:${time.hour}, mintues:${time.minute}');
  //       // dayCache.hours = time.hour;
  //       // dayCache.minutes = time.minute;
  //     });

  void _cacheHours(String hoursWorked) {
    // setState(() {
    //   // double hours = double.parse(hoursWorked);
    //   // print('cacheHours $hours');
    //   // dayCache.hoursWorked = hours;
    // });
  }

  // @override
  // void initState() {
  //   _resetState();
  //   super.initState();
  // }

  // _resetState() {
  //   controller = TextEditingController(
  //     text: widget.work.isEnabled() ? widget.work.hoursWorked.toString() : null,
  //   );
  //   dayCache = widget.work;
  // }

  @override
  Widget build(BuildContext context) {
    // if (widget.resetState) {
    //   widget.resetState = false;
    //   print('TimesEditor - resetState:true');
    //   _resetState();
    // }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _createWorkdayColumn(context),
              _createWorkBeginColumn(context),
              _createWorkHoursColumn(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _createClearButton(),
              _createSaveButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createWorkdayColumn(BuildContext context) =>
      Column(children: <Widget>[
        Text('Workday:'),
        DropDownButton(
          buttonText: fullDateFormatter.format(dayCache.date),
          onPressed: () => showDatePicker(
                context: context,
                firstDate: DateTime(2018),
                lastDate: DateTime.now().add(Duration(days: 365)),
                initialDate: work.date,
              ).then(_cacheDateTime),
        ),
      ]);

  Widget _createWorkBeginColumn(BuildContext context) =>
      Column(children: <Widget>[
        Text('Begin:'),
        DropDownButton(
          buttonText: dayCache.isEnabled() ? dayCache.timeAsString() : '-',
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                  hour: work.hours, minute: work.minutes),
            ).then(_cacheDayTime);
          },
        ),
      ]);

  Widget _createWorkHoursColumn() => Column(
        children: <Widget>[
          Text('Hours:'),
          SizedBox(
            width: 80,
            child: TextField(
              decoration: InputDecoration(hintText: 'hours'),
              controller: controller,
              maxLines: 1,
              keyboardType: TextInputType.numberWithOptions(signed: false),
              onChanged: (value) {
                print(value);
                _cacheHours(value);
              },
            ),
          ),
        ],
      );

  Widget _createSaveButton() => RaisedButton(
        child: Text('Save Changes'),
        onPressed:
            dayCache.isEnabled() ? () => saveChanges(dayCache) : null,
      );

  Widget _createClearButton() => RaisedButton(
        color: Colors.red,
        child: Text('Clear Entry'),
        onPressed:
            dayCache.isEnabled() ? () => clearEntry(index) : null,
      );
}
