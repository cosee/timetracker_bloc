import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:time_track/db/entities/work_day_db.dart';

class DBProvider {
  //Singleton
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  List<String> createStatements = [WorkDayDb.CREATE_TABLE];

  Future<Database> get database async {
    if (null == _database) {
      _database = await initDB();
    }
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'times.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        for (var create in createStatements) {
          await db.execute(create);
        }
      },
    );
  }
}
