import 'package:built_value/built_value.dart';

import 'package:time_track/model/work_day.dart';
import 'package:time_track/model/work_period.dart';

part 'main_state.g.dart';

abstract class MainState implements Built<MainState, MainStateBuilder> {
  int get selectedIndex;
  WorkPeriod get workPeriod;
  WorkDay get selectedDay => workPeriod.workDays[selectedIndex];

  MainState._(); //Private constructor
  factory MainState({
    int selectedIndex,
    WorkPeriod workPeriod,
  }) =>
      _$MainState._(
        selectedIndex: selectedIndex ?? 0,
        workPeriod: workPeriod ?? WorkPeriod.dummyList(),
      );
}
