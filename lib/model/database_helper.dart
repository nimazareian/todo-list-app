import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'todo.dart';

final String tableName = 'todo';

final String columnTitle =
    'title'; //has to be same as one of the fields of todo
final String columnId = 'id';
final String columnDescription = 'description';
final String columnDueDate = 'due_date';
final String columnDateCreated = 'date_created';
final String columnTags = 'tags';

class DatabaseHelper {
  Database db;

  DatabaseHelper() {
    initDataBase();
  }

  Future<void> initDataBase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'todo_list_db.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnTitle TEXT, $columnDescription TEXT, $columnDueDate TEXT, $columnDateCreated TEXT)');
      },
      version: 1,
    );
  }

  Future<void> insertTodo(Todo todo) async {
    try {
      db.insert(tableName, todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Todo>> getAllTodo() async {
    final List<Map<String, dynamic>> todoList = await db.query(tableName);

    List.generate(
      todoList.length,
      (index) {
        return Todo(
          id: todoList[index][columnId],
          title: todoList[index][columnTitle],
          description: todoList[index][columnDescription],
          // tags: todoList[index][columnTags],
          // dueDate: DateTime.parse(todoList[index][columnDueDate]) ?? '',
          // dateCreated: DateTime.parse(todoList[index][columnDateCreated]) ?? '',
        );
      },
    );
  }
}
