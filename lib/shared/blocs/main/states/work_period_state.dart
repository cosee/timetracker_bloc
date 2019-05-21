import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

import 'package:time_track/model/work_period.dart';
import 'package:time_track/shared/blocs/main/blocs.dart' show WorkDayState;

part 'work_period_state.g.dart';

abstract class WorkPeriodState
    implements Built<WorkPeriodState, WorkPeriodStateBuilder> {
  DateTime get periodBegin;
  DateTime get periodEnd;
  BuiltList<WorkDayState> get workDays;

  WorkPeriodState._();

  factory WorkPeriodState(
    DateTime periodBegin,
    DateTime periodEnd,
    BuiltList<WorkDayState> workDays,
  ) =>
      _$WorkPeriodState._(
        periodBegin: periodBegin,
        periodEnd: periodEnd,
        workDays: workDays,
      );

  WorkPeriod get business => WorkPeriod(
        periodBegin: periodBegin,
        periodEnd: periodEnd,
        workDays: workDays.map((f) => f.toBusiness()).toList(),
      );

  static from(WorkPeriod state) {
    int index = 0;
    return WorkPeriodState(
      state.periodBegin,
      state.periodEnd,
      BuiltList<WorkDayState>.from(
          state.workDays.map((f) => WorkDayState.from(f, index++))),
    );
  }
}
