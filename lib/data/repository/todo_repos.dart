import 'package:todo_app/data/data.dart';
import 'package:todo_app/data/data_source/database_provider.dart';

abstract class TodoRepos {
  Future<int> insertTask(Task task);
  Future<int> updateTask(Task task);
  Future<int> deleteTask(Task task);
  Future<List<Task>> getAllTask();
}

class TodoReposImpl implements TodoRepos {
  final DatabaseProvider _db;

  TodoReposImpl(this._db);

  @override
  Future<int> insertTask(Task task) async {
    return await _db.insertTask(task);
  }

  @override
  Future<int> updateTask(Task task) async {
    return await _db.updateTask(task);
  }

  @override
  Future<int> deleteTask(Task task) async {
    return await _db.deleteTask(task);
  }

  @override
  Future<List<Task>> getAllTask() async {
    return await _db.getAllTask();
  }
}
