import 'package:flutter/material.dart';

import 'package:time_track/view/shared/widgets/drop_down_button.dart';
import 'package:time_track/shared/helper/formatter.dart';

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
  double _applyBarHeight = 0.0;
  double _applyBarOpacity = 0.0;

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
          _createApplyBar()
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
          _applyBarHeight = 50;
          _applyBarOpacity = 1.0;
        }
      });

  _resetChanges() => setState(() {
        _applyBarHeight = 0.0;
        _applyBarOpacity = 0.0;
        _initState();
      });

  _createApplyBar() => AnimatedContainer(
        duration: Duration(milliseconds: 120),
        height: _applyBarHeight,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 120),
          opacity: _applyBarOpacity,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.grey,
                  child: Icon(Icons.clear),
                  onPressed: _resetChanges,
                ),
                RaisedButton(
                  color: Colors.green[300],
                  child: Icon(Icons.refresh),
                  onPressed: () => setState(() {
                        _applyBarHeight = 0.0;
                        _applyBarOpacity = 0.0;
                        widget.setPeriod(periodBegin, periodEnd);
                      }),
                ),
              ],
            ),
          ),
        ),
      );
}
