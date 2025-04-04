part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitialState extends TaskState {}

final class TaskLoadingState extends TaskState {}

final class TaskLoadedState extends TaskState {
  final List<Task> tasks;

  const TaskLoadedState({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

final class TaskInsertedState extends TaskState {}

final class TaskUpdatedState extends TaskState {
  final Task updatedTask;
  final List<Task> tasks;

  const TaskUpdatedState({required this.updatedTask, required this.tasks});

  @override
  List<Object> get props => [updatedTask, tasks];
}

final class TaskDeletedState extends TaskState {
  final List<Task> tasks;

  const TaskDeletedState({required this.tasks});

  @override
  List<Object> get props => [tasks];
}
