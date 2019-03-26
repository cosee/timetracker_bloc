import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:time_track/model/work_day.dart';
import 'package:time_track/db/Database.dart';

WorkDay workDayFromJson(String str) {
  final jsonData = json.decode(str);
  return WorkDayDb.fromJson(jsonData);
}

String workDayToJson(WorkDay data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class WorkDayDb {
  WorkDayDb();

  // static const String id = 'id';
  static const String TABLE_NAME = 'WorkDay';
  static const String date = 'date';
  static const String hours = 'hours';
  static const String minutes = 'minutes';
  static const String hoursWorked = 'hoursWorked';

  static const String CREATE_TABLE = 'CREATE TABLE $TABLE_NAME ('
      '$date INTEGER PRIMARY KEY,'
      '$hours INTEGER, '
      '$minutes INTEGER, '
      '$hoursWorked INTEGER'
      ')';

  static WorkDay fromJson(Map<String, dynamic> json) {
    var d = DateTime.fromMillisecondsSinceEpoch(json[date]);
    return WorkDay(
      date: DateTime(d.year, d.month, d.day),
      hours: json[hours],
      minutes: json[minutes],
      hoursWorked: (double.parse(json[hoursWorked].toString())),
    );
  }

  Future<int> insert(WorkDay workDay) async {
    final db = await DBProvider.db.database;
    workDay.date =
        DateTime(workDay.date.year, workDay.date.month, workDay.date.day);
    if (workDay.hoursWorked <= 0) {
      //Delete entry instead
      return await db.delete(TABLE_NAME,
          where: 'date = ?', whereArgs: [workDay.date.millisecondsSinceEpoch]);
    }
    return await db.insert(TABLE_NAME, workDay.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  get(WorkDay workDay) async {
    final db = await DBProvider.db.database;
    workDay.date =
        DateTime(workDay.date.year, workDay.date.month, workDay.date.day);

    var res = await db.query(TABLE_NAME,
        where: 'date = ?', whereArgs: [workDay.date.millisecondsSinceEpoch]);
    return res.isNotEmpty ? fromJson(res.first) : null;
  }

  _cleanDate() {}

  Future<List<WorkDay>> getAll() async {
    final db = await DBProvider.db.database;
    var res = await db.query(TABLE_NAME);
    return res.isEmpty ? [] : res.map((c) => fromJson(c)).toList();
  }
}
