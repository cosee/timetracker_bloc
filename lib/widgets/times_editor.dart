import 'package:flutter/material.dart';

import 'package:time_track/util/formatter.dart';
import 'package:time_track/widgets/drop_down_button.dart';
import 'package:time_track/model/work_day.dart';

class TimesEditor extends StatefulWidget {
  TimesEditor(
      {this.work,
      this.index,
      this.clearButtonEnabled,
      this.cacheDateTime,
      this.cacheDayTime,
      this.cacheHours,
      this.saveChanges,
      this.clearEntry,
      this.resetState});

  WorkDay work;
  int index;
  bool clearButtonEnabled;
  bool resetState;
  Function(WorkDay) cacheDateTime;
  Function(int, int) cacheDayTime;
  Function(String) cacheHours;
  Function(WorkDay) saveChanges;
  Function(int) clearEntry;

  @override
  State<StatefulWidget> createState() {
    print("CREATE of _TimesEditorState");
    return _TimesEditorState();
  }
}

class _TimesEditorState extends State<TimesEditor> {
  TextEditingController controller;

  @override
  void initState() {
    _resetState();
    super.initState();
  }

  _resetState() {
    String text = null;
    if (widget.work.isEnabled()) {
      text = widget.work.hoursWorked.toString();
    }
    controller = TextEditingController(text: text);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.resetState) {
      print("RESET_STATE = TRUE");
      _resetState();
    }

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
          buttonText: fullDateFormatter.format(widget.work.date),
          onPressed: () => showDatePicker(
                context: context,
                firstDate: DateTime(2018),
                lastDate: DateTime.now().add(Duration(days: 365)),
                initialDate: widget.work.date,
              ).then((value) {
                var d = widget.work.date;
                widget.work.date = DateTime(
                    value.year, value.month, value.day, d.hour, d.minute);
                widget.cacheDateTime(widget.work);
              }),
        ),
      ]);

  Widget _createWorkBeginColumn(BuildContext context) =>
      Column(children: <Widget>[
        Text('Begin:'),
        DropDownButton(
          buttonText:
              widget.work.isEnabled() ? widget.work.timeAsString() : '-',
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                  hour: widget.work.hours, minute: widget.work.minutes),
            ).then((value) => widget.cacheDayTime(value.hour, value.minute));
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
                widget.cacheHours(value);
              },
            ),
          ),
        ],
      );

  Widget _createSaveButton() => RaisedButton(
        child: Text('Save Changes'),
        onPressed: widget.work.isEnabled()
            ? () => widget.saveChanges(widget.work)
            : null,
      );

  Widget _createClearButton() => RaisedButton(
        color: Colors.red,
        child: Text('Clear Entry'),
        onPressed: widget.clearButtonEnabled
            ? () => widget.clearEntry(widget.index)
            : null,
      );
}
