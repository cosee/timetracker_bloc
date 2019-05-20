import 'dart:math';

import 'package:time_track/model/work_day.dart';
import 'package:time_track/shared/helper/clone.dart';
import 'package:time_track/shared/helper/compare.dart';

class WorkPeriod {
  final DateTime periodBegin;
  final DateTime periodEnd;
  List<WorkDay> workDays;

  WorkPeriod(
      {this.periodBegin,
      this.periodEnd,
      this.workDays,
      bool generateMissingDays = true}) {
    var delta = periodBegin.difference(periodEnd);
    var days = sqrt(delta.inDays * delta.inDays).toInt();
    print('delta.inDays:$days');
    if (null == workDays) {
      workDays = List<WorkDay>();
    }
    if (workDays.length < days) {
      var deltaExisting = workDays.length - days;
      var unsignedDays = sqrt(deltaExisting * deltaExisting).toInt();

      if (generateMissingDays) {
        _generateMissingWorkDays(unsignedDays);
      }
    }
  }

  _generateMissingWorkDays(int numberOfDays) {
    var pivot = cloneDT(periodBegin);
    for (var i = 0; i < numberOfDays; i++) {
      WorkDay day = null;

      if (workDays.isNotEmpty) {
        day = workDays.firstWhere(
          (test) => isSameDate(test.date, pivot),
          orElse: () => null,
        );
      }

      if (null == day) {
        workDays.add(WorkDay(
            date: cloneDT(pivot), hours: 0, minutes: 0, hoursWorked: 0));
      }
      pivot = pivot.add(Duration(days: 1));
    }

    workDays.sort((it, other) => it.date.isBefore(other.date) ? 0 : 1);
  }



  ////////////Mocking values:

  static WorkPeriod dummyList() {
    DateTime now = DateTime.now();
    return WorkPeriod(
      periodBegin: DateTime.now(),
      periodEnd: DateTime.now().add(Duration(days: 31)),
      workDays: _generateRandomDates(now),
    );
  }

  static double _getRandomNumber(Random rand, int floor) {
    var x = (rand.nextInt(11).toDouble() - 3);
    return (x > 0) ? x : 0;
  }

  static List<WorkDay> _generateRandomDates(DateTime now) {
    List<WorkDay> workDays = List<WorkDay>();
    var rand = Random();

    for (var i = 0; i < 31; i++) {
      workDays.add(WorkDay(
        date: now.add(Duration(
          days: i,
        )),
        hours: 8,
        minutes: i,
        hoursWorked: _getRandomNumber(rand, 0),
      ));
    }
    return workDays;
  }
}
