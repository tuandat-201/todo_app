import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/bloc/task_bloc/bloc/task_bloc.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/widgets.dart';

class ListTask extends StatelessWidget {
  const ListTask({
    super.key,
    required this.tasks,
    this.isCompletedTask = false,
  });

  final List<Task> tasks;
  final bool isCompletedTask;

  Widget _showDialog(BuildContext context, Task task) {
    final alertDialog = AlertDialog(
      title: const Text('Bạn có muốn xóa ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Không',
            style: context.textTheme.bodyLarge!.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<TaskBloc>().add(TaskDeleteEvent(task: task));
            Navigator.of(context).pop();
          },
          child: Text(
            'Có',
            style: context.textTheme.bodyLarge!.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );

    return alertDialog;
  }

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    final textTheme = context.textTheme;
    final emptyMessage = isCompletedTask
        ? 'Không có công việc hoàn thành'
        : 'Không có công việc chưa hoàn thành';

    Widget content = tasks.isEmpty
        ? Center(
            child: Text(emptyMessage),
          )
        : ListView.separated(
            itemCount: tasks.length,
            padding: EdgeInsets.zero,
            itemBuilder: (ctx, index) => InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    final task = tasks[index];
                    return Container(
                      height: size.height * 0.6,
                      width: size.width,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          IconContainer(
                            category: task.category,
                            iconSize: 40,
                          ),
                          const Gap(10),
                          Text(
                            task.title,
                            style: textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            task.time,
                            style: textTheme.bodyMedium,
                          ),
                          const Gap(15),
                          Visibility(
                            visible: !task.isCompleted,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Công việc phải hoàn thành vào ${task.date}'),
                                const Gap(5),
                                Icon(
                                  Icons.check_box,
                                  color: task.category.color,
                                ),
                              ],
                            ),
                          ),
                          const Gap(15),
                          Divider(
                            thickness: 1.5,
                            color: task.category.color,
                          ),
                          const Gap(15),
                          Text(task.note.isEmpty
                              ? 'Không có ghi chú'
                              : task.note),
                          const Gap(10),
                          Visibility(
                            visible: task.isCompleted,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Công việc đã hoàn thành'),
                                const Gap(5),
                                Icon(
                                  Icons.check_box,
                                  color: task.category.color,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              onLongPress: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return _showDialog(context, tasks[index]);
                  },
                );
              },
              child: TaskItem(
                task: tasks[index],
              ),
            ),
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1,
                color: Colors.black.withAlpha(50),
              );
            },
          );

    return CommonContainer(
      child: content,
    );
  }
}
