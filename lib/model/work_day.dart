import 'package:time_track/util/clone.dart';

class WorkDay {
  WorkDay({this.date, this.hours, this.minutes, this.hoursWorked});

  WorkDay clone() => WorkDay(
        date: cloneDT(date),
        hours: hours,
        minutes: minutes,
        hoursWorked: hoursWorked,
      );

  DateTime date;
  int hours;
  int minutes;
  double hoursWorked;


  timeAsString() => '${_addPadding(hours)}:${_addPadding(minutes)}';
  _addPadding(int value) => value.toString().padLeft(2, '0');
  

  isEnabled() => (hoursWorked ?? 0) > 0;

  Map<String, dynamic> toJson() => {
        "date": date.millisecondsSinceEpoch,
        "minutes": minutes,
        "hours": hours,
        "hoursWorked": hoursWorked,
      };
}
