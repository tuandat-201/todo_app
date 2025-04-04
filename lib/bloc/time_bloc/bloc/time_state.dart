part of 'time_bloc.dart';

sealed class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

final class TimeInitialState extends TimeState {}

final class TimeSelectedState extends TimeState {
  final TimeOfDay time;

  const TimeSelectedState({required this.time});

  @override
  List<Object> get props => [time];
}

final class TimeErrorState extends TimeState {}
