import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_bloc/bloc/task_bloc.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/widgets.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final lineThrough =
        task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: IconContainer(category: task.category),
      title: Column(
        children: [
          Text(
            task.title,
            style: textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              decoration: lineThrough,
            ),
          ),
          Text(
            task.time,
            style: textTheme.bodySmall!.copyWith(
              decoration: lineThrough,
            ),
          ),
        ],
      ),
      trailing: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          final updateTask = task.copyWith(isCompleted: value);
          context.read<TaskBloc>().add(TaskUpdateEvent(task: updateTask));
        },
      ),
    );
  }
}
