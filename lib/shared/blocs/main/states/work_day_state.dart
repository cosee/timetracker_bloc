import 'package:built_value/built_value.dart';

import 'package:time_track/model/work_day.dart';

// import 'package:time_track/shared/blocs/main/blocs.dart' show WorkPeriodState, WorkPeriodStateBuilder;

part 'work_day_state.g.dart';

abstract class WorkDayState
    implements Built<WorkDayState, WorkDayStateBuilder> {
  DateTime get date;
  int get hours;
  int get minutes;
  double get hoursWorked;

  int get index; //for editor

  WorkDayState._();
  factory WorkDayState.empty() => _$WorkDayState._();

  factory WorkDayState(
    DateTime date,
    int hours,
    int minutes,
    double hoursWorked,
    int index,
  ) =>
      _$WorkDayState._(
        date: date,
        hours: hours,
        minutes: minutes,
        hoursWorked: hoursWorked,
        index: index,
      );

  timeAsString() => '${_addPadding(hours)}:${_addPadding(minutes)}';
  _addPadding(int value) => value.toString().padLeft(2, '0');

  isEnabled() => (hoursWorked ?? 0) > 0;

  toBusiness() => WorkDay(
        date: date,
        hours: hours,
        minutes: minutes,
        hoursWorked: hoursWorked,
      );

  static WorkDayState from(WorkDay workDay, int index) => WorkDayState(
        workDay.date,
        workDay.hours,
        workDay.minutes,
        workDay.hoursWorked,
        index,
      );

  String toString() =>
      'date: $date\nhours: $hours\nminutes: $minutes\nhoursWorked: $hoursWorked';
}
