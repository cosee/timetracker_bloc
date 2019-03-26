import 'package:flutter/material.dart';

import 'package:time_track/widgets/drop_down_button.dart';
import 'package:time_track/util/formatter.dart';

class PeriodSelector extends StatefulWidget {
  PeriodSelector(this.periodBegin, this.periodEnd);

  final DateTime periodBegin;
  final DateTime periodEnd;

  @override
  State<StatefulWidget> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector> {
  DateTime periodBegin;
  DateTime periodEnd;

  @override
  void initState() {
    periodBegin = widget.periodBegin;
    periodEnd = widget.periodEnd;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('Period:'),
          _createDatePicker(periodBegin),
          _createDatePicker(periodEnd),
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
        if (periodBegin == oldValue) {
          periodBegin = newValue;
        } else {
          periodEnd = newValue;
        }
      });
}
