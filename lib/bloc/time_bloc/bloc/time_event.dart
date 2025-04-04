part of 'time_bloc.dart';

sealed class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object> get props => [];
}

final class TimeStartEvent extends TimeEvent {}

final class TimeChangedEvent extends TimeEvent {
  final TimeOfDay time;

  const TimeChangedEvent({required this.time});

  @override
  List<Object> get props => [time];
}
