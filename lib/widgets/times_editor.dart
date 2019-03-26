import 'package:flutter/material.dart';

import 'package:time_track/util/formatter.dart';
import 'package:time_track/widgets/drop_down_button.dart';
import 'package:time_track/model/work_day.dart';

class TimesEditor extends StatelessWidget {
  TimesEditor(
      {this.work,
      this.index,
      this.cacheDateTime,
      this.cacheDayTime,
      this.cacheHours,
      this.saveChanges,
      this.clearEntry});

  WorkDay work;
  int index;
  Function(WorkDay) cacheDateTime;
  Function(int, int) cacheDayTime;
  Function(String) cacheHours;
  Function(WorkDay) saveChanges;
  Function(int) clearEntry;

  @override
  Widget build(BuildContext context) {
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
          buttonText: fullDateFormatter.format(work.date),
          onPressed: () => showDatePicker(
                context: context,
                firstDate: DateTime(2018),
                lastDate: DateTime.now().add(Duration(days: 365)),
                initialDate: work.date,
              ).then((value) {
                var d = work.date;
                work.date = DateTime(
                    value.year, value.month, value.day, d.hour, d.minute);
                cacheDateTime(work);
              }),
        ),
      ]);

  Widget _createWorkBeginColumn(BuildContext context) =>
      Column(children: <Widget>[
        Text('Begin:'),
        DropDownButton(
          buttonText: work.isEnabled() ? work.timeAsString() : '-',
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: work.hours, minute: work.minutes),
            ).then((value) => cacheDayTime(value.hour, value.minute));
          },
        ),
      ]);

  Widget _createWorkHoursColumn() => Column(
        children: <Widget>[
          Text('Hours:'),
          SizedBox(
            width: 80,
            child: TextField(
              controller:
                  TextEditingController(text: work.hoursWorked.toString()),
              maxLines: 1,
              keyboardType: TextInputType.numberWithOptions(signed: false),
              onChanged: (value) {
                cacheHours(value);
              },
            ),
          ),
        ],
      );

  Widget _createSaveButton() => RaisedButton(
        child: Text('Save Changes'),
        onPressed: work.isEnabled() ? () => saveChanges(work) : null,
      );

  Widget _createClearButton() => RaisedButton(
        color: Colors.red,
        child: Text('Clear Entry'),
        onPressed: (work?.isEnabled() == true) ? () => clearEntry(index) : null,
      );
}
