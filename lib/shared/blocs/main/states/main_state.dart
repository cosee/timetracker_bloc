import 'package:built_value/built_value.dart';

import 'package:time_track/model/work_period.dart';
import 'package:time_track/shared/blocs/main/blocs.dart'
    show WorkDayState, WorkPeriodState, WorkPeriodStateBuilder;

part 'main_state.g.dart';

abstract class MainState implements Built<MainState, MainStateBuilder> {
  int get selectedIndex;
  WorkPeriodState get workPeriod;
  WorkDayState get selectedDay => workPeriod.workDays[selectedIndex];

  MainState._(); //Private constructor
  factory MainState({
    int selectedIndex,
    WorkPeriod workPeriod,
  }) =>
      _$MainState._(
        selectedIndex: selectedIndex ?? 0,
        workPeriod: WorkPeriodState.from(workPeriod) ??
            WorkPeriodState.from(WorkPeriod.dummyList()),
      );
}
