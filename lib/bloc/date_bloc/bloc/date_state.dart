part of 'date_bloc.dart';

sealed class DateState extends Equatable {
  const DateState();

  @override
  List<Object> get props => [];
}

final class DateInitial extends DateState {}

final class DateLoaded extends DateState {
  final DateTime date;

  const DateLoaded({required this.date});

  @override
  List<Object> get props => [date];
}

final class DateErrorState extends DateState {}
