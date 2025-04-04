import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  TimeBloc() : super(TimeInitialState()) {
    on<TimeStartEvent>(_onTimeStartEvent);
    on<TimeChangedEvent>(_onTimeChangedEvent);
  }

  Future<void> _onTimeStartEvent(
    TimeStartEvent event,
    Emitter<TimeState> emit,
  ) async {
    final now = TimeOfDay.now();

    emit(TimeSelectedState(time: now));
  }

  Future<void> _onTimeChangedEvent(
    TimeChangedEvent event,
    Emitter<TimeState> emit,
  ) async {
    if (state is TimeSelectedState) {
      final newTime = event.time;
      emit(TimeSelectedState(time: newTime));
    }
  }
}
