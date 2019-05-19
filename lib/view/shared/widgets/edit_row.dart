import 'package:flutter/material.dart';

import 'package:time_track/model/work_day.dart';
import 'package:time_track/shared/helper/formatter.dart';

class EditRow extends StatelessWidget {
  EditRow({
    this.workEntry,
    this.index,
    this.selectDay,
    this.isSelected = false,
  });

  final WorkDay workEntry;
  final int index;
  final Function(int) selectDay;
  final bool isSelected;

  Color _getRowColor(BuildContext context) {
    var theme = Theme.of(context);

    var color = (workEntry.date.weekday < 6)
        ? theme.buttonColor
        : theme.accentColor.withOpacity(0.8);
    return isSelected ? Colors.pinkAccent : color;
  }

  @override
  Widget build(BuildContext context) => Container(
        color: _getRowColor(context),
        margin: EdgeInsets.only(top: 4),
        height: 25,
        child: FlatButton(
          onPressed: () => selectDay(index),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: 50,
                child: Text(weekDayFormatter.format(workEntry.date)),
              ),
              Container(
                width: 80,
                child: Text(dateFormatter.format(workEntry.date)),
              ),
              Container(
                width: 50,
                child: Text(
                    workEntry.isEnabled() ? workEntry.timeAsString() : '-'),
              ),
              Container(
                width: 80,
                child: Text(workEntry.isEnabled()
                    ? workEntry.hoursWorked.toString()
                    : '-'),
              )
            ],
          ),
        ),
      );
}
