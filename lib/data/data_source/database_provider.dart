import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/data.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );

    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        note TEXT,
        time TEXT,
        date TEXT,
        category TEXT,
        isCompleted INTEGER
      )
    ''');
  }

  Future<int> insertTask(Task task) async {
    final database = await db.database;
    return await database!.insert('todo', task.toMap());
  }

  Future<int> updateTask(Task task) async {
    final database = await db.database;
    return await database!
        .update('todo', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(Task task) async {
    final database = await db.database;
    return await database!
        .delete('todo', where: 'id = ?', whereArgs: [task.id]);
  }

  Future<List<Task>> getAllTask() async {
    final database = await db.database;
    final data = await database!.query('todo');

    return List.generate(
      data.length,
      (index) => Task.fromMap(data[index]),
    );
  }
}
