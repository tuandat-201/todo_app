import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/date_bloc/bloc/date_bloc.dart';
import 'package:todo_app/bloc/task_bloc/bloc/task_bloc.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/utils/helpers.dart';

class SelectDateOnHomeScreen extends StatelessWidget {
  const SelectDateOnHomeScreen({
    super.key,
  });

  void _showDatePicker(BuildContext context, DateTime date) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2025),
      lastDate: DateTime(2090),
    );

    if (picked != null && context.mounted) {
      context.read<DateBloc>().add(DateSelectedEvent(date: picked));
      context.read<TaskBloc>().add(TaskLoadingEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return BlocBuilder<DateBloc, DateState>(
      builder: (context, state) {
        final date = state is DateLoaded ? state.date : DateTime.now();

        return InkWell(
          onTap: () {
            _showDatePicker(context, date);
          },
          child: Text(
            Helpers.formatDate(date),
            style: textTheme.titleMedium!.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        );
      },
    );
  }
}
