import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(DateInitial()) {
    on<DateStartEvent>(_onDateStartEvent);
    on<DateSelectedEvent>(_onDateSelectedEvent);
  }

  Future<void> _onDateStartEvent(
    DateStartEvent event,
    Emitter<DateState> emit,
  ) async {
    final DateTime now = DateTime.now();
    emit(DateLoaded(date: now));
  }

  Future<void> _onDateSelectedEvent(
    DateSelectedEvent event,
    Emitter<DateState> emit,
  ) async {
    final state = this.state;
    if (state is DateLoaded) {
      final DateTime date = event.date;
      emit(DateLoaded(date: date));
    }
  }
}
