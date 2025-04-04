part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class TaskLoadingEvent extends TaskEvent {}

final class TaskInsertEvent extends TaskEvent {
  final Task task;

  const TaskInsertEvent({required this.task});

  @override
  List<Object> get props => [task];
}

final class TaskUpdateEvent extends TaskEvent {
  final Task task;

  const TaskUpdateEvent({required this.task});

  @override
  List<Object> get props => [task];
}

final class TaskDeleteEvent extends TaskEvent {
  final Task task;

  const TaskDeleteEvent({required this.task});

  @override
  List<Object> get props => [task];
}
