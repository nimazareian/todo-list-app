import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'todo.dart';

final String _databaseName = 'todo_list_db.db';

final String tableName = 'todo';

final String columnTitle =
    'title'; //has to be same as one of the fields of todo
final String columnId = 'id';
final String columnDescription = 'description';
final String columnDueDate = 'due_date';
final String columnIsFinish = 'is_finish';
final String columnDateCreated = 'date_created';
final String columnTags = 'tags';

final int _databaseVersion = 1;

class DatabaseHelper {
  static Database _datebase;

  // DatabaseHelper() {
  //   initDataBase();
  // }

  // singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_datebase != null) return _datebase;

    _datebase = await _initDatabase();
    return _datebase;
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnTitle TEXT, 
      $columnDescription TEXT, 
      $columnDueDate TEXT, 
      $columnDateCreated TEXT,
      $columnTags TEXT,
      $columnIsFinish INTEGER
      )''');
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      // onUpgrade: _onUpgrade,
    );
  }

  // UPGRADE DATABASE TABLES
  // void _onUpgrade(Database db, int oldVersion, int newVersion) {
  //   if (oldVersion < newVersion) {
  //     db.execute("ALTER TABLE tabEmployee ADD COLUMN newCol TEXT;");
  //   }
  // }

  // Future<void> initDataBase() async {
  //   _datebase = await openDatabase(
  //     join(await getDatabasesPath(), _databaseName),
  //     onCreate: _onCreate,
  //     version: _databaseVersion,
  //   );
  // }

  Future<void> insertTodo(Todo todo) async {
    Database db = await instance.database;
    try {
      db.insert(
        tableName,
        todo.toMap(), //////////////////////////////////////////////////////////////////
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Todo>> getAllTodo() async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> todoList = await db.query(tableName);

    return List.generate(
      todoList.length,
      (index) {
        return Todo(
          id: todoList[index][columnId],
          title: todoList[index][columnTitle],
          description: todoList[index][columnDescription],
          isFinish: todoList[index][columnIsFinish] == 1 ? true : false,
          tags: Todo.stringToList(todoList[index][columnTags]),
          dueDate: DateTime.parse(todoList[index][columnDueDate] ??
              DateTime.now().toString()), // Modify this
          dateCreated: DateTime.parse(DateTime.now().toString()),
          // DateTime.parse(
          //     todoList[index][columnDateCreated] ??
          //     DateTime.now().toString()),
        );
      },
    );
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Todo todo) async {
    Database db = await instance.database;
    int id = todo.id;
    return await db.update(tableName, todo.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  static Future<void> deleteData() async {
    String path = join(await getDatabasesPath(), _databaseName);
    await deleteDatabase(path);
    print('DELETED DATABASE');
  }
}
