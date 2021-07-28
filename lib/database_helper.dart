import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/task.dart';

class DatabaseHelper{

  Future<Database> database() async{
    return openDatabase(
        join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version){
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      }
    );
  }
  
  Future<void> insertTask(Task task) async {
    Database _db = await database();
    var conflictAlgorithm;
    await _db.insert('task', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace );
  }
}