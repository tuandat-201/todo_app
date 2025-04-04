import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/date_bloc/bloc/date_bloc.dart';
import 'package:todo_app/utils/helpers.dart';
import 'package:todo_app/widgets/widgets.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateBloc, DateState>(
      builder: (context, state) {
        if (state is DateLoaded) {
          final DateTime date = state.date;

          return CommonTextFeild(
            title: 'Ngày hẹn',
            hintText: Helpers.formatDate(date),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () {
                _showDatePicker(context, date);
              },
              icon: const Icon(Icons.calendar_month),
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
