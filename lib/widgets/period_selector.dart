import 'package:flutter/material.dart';

import 'package:time_track/widgets/drop_down_button.dart';
import 'package:time_track/util/formatter.dart';

class PeriodSelector extends StatefulWidget {
  PeriodSelector(this.periodBegin, this.periodEnd, this.setPeriod);

  final DateTime periodBegin;
  final DateTime periodEnd;
  final Function(DateTime begin, DateTime end) setPeriod;

  @override
  State<StatefulWidget> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  DateTime periodBegin;
  DateTime periodEnd;
  bool showApplyBar = false;

  @override
  void initState() {
    _initState();
    super.initState();
  }

  _initState() {
    periodBegin = widget.periodBegin;
    periodEnd = widget.periodEnd;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Period:'),
              _createDatePicker(periodBegin),
              _createDatePicker(periodEnd),
            ],
          ),
          showApplyBar ? _createApplyBar() : Container(),
        ],
      ),
    );
  }

  _createDatePicker(DateTime initialDate) => DropDownButton(
      buttonText: dateFormatter.format(initialDate),
      onPressed: () => showDatePicker(
            context: context,
            firstDate: DateTime.now().subtract(Duration(days: 356)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            initialDate: initialDate,
          ).then(
            (value) => _changeDate(value, initialDate),
          ));

  _changeDate(DateTime newValue, DateTime oldValue) => setState(() {
        if (null != newValue) {
          if (periodBegin == oldValue) {
            periodBegin = newValue;
          } else {
            periodEnd = newValue;
          }
          showApplyBar = true;
        }
      });

  _resetChanges() => setState(() {
        showApplyBar = false;
        _initState();
      });

  _createApplyBar() => Container(
        // margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              color: Colors.red,
              child: Icon(Icons.clear),
              onPressed: _resetChanges(),
            ),
            RaisedButton(
              color: Colors.green,
              child: Icon(Icons.refresh),
              onPressed: () => setState(() {
                    showApplyBar = false;
                    widget.setPeriod(periodBegin, periodEnd);
                  }),
            ),
          ],
        ),
      );
}
