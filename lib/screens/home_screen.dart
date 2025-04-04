import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/bloc/date_bloc/bloc/date_bloc.dart';
import 'package:todo_app/bloc/task_bloc/bloc/task_bloc.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/screens/screens.dart';
import 'package:todo_app/utils/helpers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/select_date_on_home_screen.dart';
import 'package:todo_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _moveToAddTodoScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const AddTodoScreen()));
  }

  List<Task> _filterTasks(List<Task> tasks, BuildContext context,
      {required bool completed}) {
    final dateState = context.read<DateBloc>().state;
    final date = dateState is DateLoaded ? dateState.date : DateTime.now();
    final formattedDate = Helpers.formatDate(date);

    return tasks
        .where(
          (task) => task.isCompleted == completed && task.date == formattedDate,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskUpdatedState) {
          final message = state.updatedTask.isCompleted
              ? 'Đã đánh dấu hoàn thành'
              : 'Đã đánh dấu chưa hoàn thành';

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      },
      builder: (context, state) {
        final List<Task> tasks;
        if (state is TaskLoadedState) {
          tasks = state.tasks;
        } else if (state is TaskUpdatedState) {
          tasks = state.tasks;
        } else if (state is TaskDeletedState) {
          tasks = state.tasks;
        } else {
          tasks = [];
        }

        final inCompleteTask = _filterTasks(tasks, context, completed: false);
        final completedTask = _filterTasks(tasks, context, completed: true);

        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: size.height * 0.3,
                    width: size.width,
                    color: colorScheme.primary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SelectDateOnHomeScreen(),
                        const Gap(10),
                        Text(
                          'Danh sách việc cần làm',
                          style: textTheme.titleLarge!.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 170,
                right: 0,
                left: 0,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTask(
                        tasks: inCompleteTask,
                      ),
                      const Gap(20),
                      Text(
                        'Công việc đã hoàn thành',
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(20),
                      ListTask(
                        tasks: completedTask,
                        isCompletedTask: true,
                      ),
                      const Gap(20),
                      CommonButton(
                        title: 'Thêm công việc mới',
                        onPressed: () {
                          _moveToAddTodoScreen(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
