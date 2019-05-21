import 'package:flutter/material.dart';
import 'package:time_track/shared/blocs/main/blocs.dart';

import 'package:time_track/shared/helper/formatter.dart';
import 'package:time_track/view/shared/widgets/centered_loading_spinner.dart';
import 'package:time_track/view/shared/widgets/drop_down_button.dart';

class TimesEditor extends StatefulWidget {
  TimesEditor({
    this.index,
    this.clearButtonEnabled,
    this.stream,
    this.sink,
  });

  final int index;
  final bool clearButtonEnabled;
  final Stream<WorkDayState> stream;
  final Sink<WorkDayState> sink;

  @override
  State<StatefulWidget> createState() => _TimesEditorState();
}

class _TimesEditorState extends State<TimesEditor> {
  @override
  void initState() {
    _createEditorBloc();
    _resetTextController();
    super.initState();
  }

  TextEditingController controller;
  EditorBloc _editorBloc;
  WorkDayState lastState;

  EditorBloc _createEditorBloc() {
    _editorBloc = EditorBloc(widget.stream, widget.sink);
    return _editorBloc;
  }

  void _cacheDateTime(DateTime date) {
    _editorBloc.cacheChanges.add(CacheChangeAction.cacheDate(date));
  }

  void _cacheDayTime(TimeOfDay time) {
    var timeOfDay = DateTime(0, 0, 0, time.hour, time.minute);
    _editorBloc.cacheChanges.add(CacheChangeAction.cacheTime(timeOfDay));
  }

  void _cacheWorkedHours(String hoursWorked) {
    _editorBloc.cacheChanges.add(CacheChangeAction.cacheWorkHours(hoursWorked));
  }

  @override
  didUpdateWidget(TimesEditor oldWidget) {
    print('didUpdateWidget');
    if (oldWidget.index != widget.index) {
      _createEditorBloc();
      _resetTextController();
    }
    super.didUpdateWidget(oldWidget);
  }

  _resetTextController({double value}) {
    print('Reset textController');
    // print('initial: ${_editorBloc.initialState}');
    // print('value: ${value}');
    String text = value?.toString();
    if (null == text) {
      text = (_editorBloc.initialState?.isEnabled() ?? false)
          ? _editorBloc.initialState.hoursWorked.toString()
          : null;
    }
    //Fix this better maybe?
    if (null == controller || text != controller?.text) {
      controller = TextEditingController(text: text);
    }
  }

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
      child: StreamBuilder(
          stream: _editorBloc.state,
          initialData: _editorBloc.initialState,
          builder:
              (BuildContext context, AsyncSnapshot<WorkDayState> snapshot) {
            if (snapshot.hasData) {
              //The user can't do anything withouth this being up to date!
              lastState = snapshot.data;
              _resetTextController(value: snapshot.data.hoursWorked);

              return Column(
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
              );
            } else {
              return CenteredLoadingSpinner(
                text: 'DOOM!',
              );
            }
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
                initialDate: lastState.date,
              ).then(_cacheDateTime),
        ),
      ]);

  Widget _createWorkBeginColumn(BuildContext context) {
    print('creating workbeginColumn: ${lastState.timeAsString()}');

    return Column(children: <Widget>[
      Text('Begin:'),
      DropDownButton(
        buttonText: lastState.isEnabled() ? lastState.timeAsString() : '-',
        onPressed: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay(
              hour: lastState.hours,
              minute: lastState.minutes,
            ),
          ).then(_cacheDayTime);
        },
      ),
    ]);
  }

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
            ? () => _editorBloc.saveChanges.add(SaveChangesAction(widget.index))
            : null,
      );

  Widget _createClearButton() => RaisedButton(
        color: Colors.red,
        child: Text('Clear Entry'),
        onPressed: lastState.isEnabled()
            ? () => _editorBloc.clearEntry.add(ClearEntryAction(widget.index))
            : null,
      );
}
