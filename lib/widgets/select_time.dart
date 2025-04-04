import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/time_bloc/bloc/time_bloc.dart';
import 'package:todo_app/utils/helpers.dart';
import 'package:todo_app/widgets/widgets.dart';

class SelectTime extends StatelessWidget {
  const SelectTime({super.key});

  void _showTimePicker(BuildContext context, TimeOfDay time) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (picked != null && context.mounted) {
      context.read<TimeBloc>().add(TimeChangedEvent(time: picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeBloc, TimeState>(
      builder: (context, state) {
        if (state is TimeSelectedState) {
          final time = state.time;

          return CommonTextFeild(
            title: 'Thời gian',
            hintText: Helpers.formatTime(time),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {
                _showTimePicker(context, time);
              },
              icon: const Icon(Icons.timer),
              style: IconButton.styleFrom(
                overlayColor: Colors.transparent,
              ),
            ),
          );
        } else {
          return const Placeholder();
        }
      },
    );
  }
}
