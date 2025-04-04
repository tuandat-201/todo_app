part of 'date_bloc.dart';

sealed class DateEvent extends Equatable {
  const DateEvent();

  @override
  List<Object> get props => [];
}

final class DateStartEvent extends DateEvent {}

final class DateSelectedEvent extends DateEvent {
  final DateTime date;

  const DateSelectedEvent({required this.date});

  @override
  List<Object> get props => [date];
}
