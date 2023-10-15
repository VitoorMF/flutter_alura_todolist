

import 'package:flutter_alura/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async{
  final String path = join(await getDatabasesPath(), 'task02.db');

  return openDatabase(path, onCreate: (db, version){
    db.execute(TaskDao.tableSql);
  }, version: 1);
}


