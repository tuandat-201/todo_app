import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/data/repository/todo_repos.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TodoReposImpl _repos;

  TaskBloc(this._repos) : super(TaskInitialState()) {
    on<TaskLoadingEvent>(_onTaskLoadingEvent);
    on<TaskInsertEvent>(_onTaskInsertEvent);
    on<TaskUpdateEvent>(_onTaskUpdateEvent);
    on<TaskDeleteEvent>(_onTaskDeleteEvent);
  }

  Future<void> _onTaskLoadingEvent(
    TaskLoadingEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadingState());
    final tasks = await _repos.getAllTask();
    emit(TaskLoadedState(tasks: tasks));
  }

  Future<void> _onTaskInsertEvent(
    TaskInsertEvent event,
    Emitter<TaskState> emit,
  ) async {
    final newTask = event.task;
    await _repos.insertTask(newTask);
    emit(TaskInsertedState());
    final tasks = await _repos.getAllTask();
    emit(TaskLoadedState(tasks: tasks));
  }

  Future<void> _onTaskUpdateEvent(
    TaskUpdateEvent event,
    Emitter<TaskState> emit,
  ) async {
    final task = event.task;
    await _repos.updateTask(task);
    final tasks = await _repos.getAllTask();
    emit(TaskUpdatedState(updatedTask: task, tasks: tasks));
    emit(TaskLoadedState(tasks: tasks));
  }

  Future<void> _onTaskDeleteEvent(
    TaskDeleteEvent event,
    Emitter<TaskState> emit,
  ) async {
    final task = event.task;
    await _repos.deleteTask(task);
    final tasks = await _repos.getAllTask();
    emit(TaskLoadedState(tasks: tasks));
  }
}
