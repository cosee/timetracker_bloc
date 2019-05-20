import 'package:flutter/material.dart';
import 'package:time_track/shared/blocs/main/blocs.dart';

import 'package:time_track/shared/helper/formatter.dart';
import 'package:time_track/view/shared/widgets/centered_loading_spinner.dart';
import 'package:time_track/view/shared/widgets/drop_down_button.dart';
import 'package:time_track/model/work_day.dart';

class TimesEditor extends StatelessWidget {
  WorkDayState lastState;

  TimesEditor({
    this.index,
    this.clearButtonEnabled,
    this.editorBloc,
  });

  final EditorBloc editorBloc;

  // final WorkDayState work;
  final int index;
  final bool clearButtonEnabled;

  TextEditingController controller;

  void _cacheDateTime(DateTime date) {
    editorBloc.cacheChanges.add(CacheChangeAction.cacheDate(date));
  }

  void _cacheDayTime(TimeOfDay time) {
    var timeOfDay = DateTime(
      0,
      0,
      0,
      time.hour,
      time.minute,
    );
    editorBloc.cacheChanges.add(CacheChangeAction.cacheTime(timeOfDay));
  }

  void _cacheWorkedHours(String hoursWorked) {
    editorBloc.cacheChanges.add(CacheChangeAction.cacheWorkHours(hoursWorked));
  }

  _resetState() {
    print('Reset state');
    String text =
        lastState.isEnabled() ? lastState.hoursWorked.toString() : null;
    if (null == controller) {
      controller = TextEditingController(text: text);
    }
    controller.text = text;
  }

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
      child: StreamBuilder(
          stream: editorBloc.state,
          // initialData: editorBloc.initialState,
          builder:
              (BuildContext context, AsyncSnapshot<WorkDayState> snapshot) {
            if (snapshot.hasData) {
              lastState = snapshot.data;
              if (null == controller?.text ||
                  controller.text.isEmpty ||
                  double.parse(controller?.text) != lastState.hours) {
                _resetState();
              }
            }

            return snapshot.hasData
                ? Column(
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
                  )
                : CenteredLoadingSpinner(
                    text: 'DOOM!',
                  );
          }),
    );
  }

  Widget _createWorkdayColumn(BuildContext context) =>
      Column(children: <Widget>[
        Text('Workday:'),
        DropDownButton(
          buttonText: fullDateFormatter.format(lastState.date),
          onPressed: () => showDatePicker(
                context: context,
                firstDate: DateTime(2018),
                lastDate: DateTime.now().add(Duration(days: 365)),
                // initialDate: editorBloc.initialState.date,
                initialDate: lastState.date,
              ).then(_cacheDateTime),
        ),
      ]);

  Widget _createWorkBeginColumn(BuildContext context) =>
      Column(children: <Widget>[
        Text('Begin:'),
        DropDownButton(
          buttonText: lastState.isEnabled() ? lastState.timeAsString() : '-',
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                hour: lastState.hours,
                minute: lastState.minutes,
              )

              // editorBloc.initialState.;}
              ,
              // TimeOfDay(hour: work.hours, minute: work.minutes),
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
                _cacheWorkedHours(value);
              },
            ),
          ),
        ],
      );

  Widget _createSaveButton() => RaisedButton(
        child: Text('Save Changes'),
        onPressed: lastState.isEnabled()
            ? () => editorBloc.saveChanges.add(SaveChangesAction(index))
            : null,
      );

  Widget _createClearButton() => RaisedButton(
        color: Colors.red,
        child: Text('Clear Entry'),
        onPressed: lastState.isEnabled()
            ? () => editorBloc.clearEntry.add(ClearEntryAction(index))
            // clearEntry(index)
            : null,
      );
}
