import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:todo_app/bloc/date_bloc/bloc/date_bloc.dart';
import 'package:todo_app/bloc/task_bloc/bloc/task_bloc.dart';
import 'package:todo_app/bloc/time_bloc/bloc/time_bloc.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/utils/helpers.dart';
import 'package:todo_app/widgets/widgets.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _addTask() {
    final title = titleController.text;
    final note = noteController.text;

    if (title.isNotEmpty) {
      final category =
          (context.read<CategoryBloc>().state as CategorySelectedState)
              .category;
      final date = (context.read<DateBloc>().state as DateLoaded).date;
      final time = (context.read<TimeBloc>().state as TimeSelectedState).time;

      final task = Task(
          title: title,
          note: note,
          time: Helpers.formatTime(time),
          date: Helpers.formatDate(date),
          category: category,
          isCompleted: false);

      context.read<TaskBloc>().add(TaskInsertEvent(task: task));
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Không được để trống công việc cần làm')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskInsertedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Thêm công việc thành công'),
            ),
          );
          titleController.clear();
          noteController.clear();
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          context.read<DateBloc>().add(DateStartEvent());
          context.read<TimeBloc>().add(TimeStartEvent());
          context.read<CategoryBloc>().add(CategoryStartEvent());

          /*Gọi lại sự kiện TaskLoadingEvent để load lại danh sách công việc,
            Nếu không gọi sự kiện này, thì khi thêm task mới, phần SelectDateOnHomeScreen sẽ hiển thị ngày hôm nay,
            Nhưng phần danh sách công việc sẽ hiển thị danh sách công việc của ngày được thêm mới
          */
          context.read<TaskBloc>().add(TaskLoadingEvent());
          Navigator.pop(context);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Thêm công việc cần làm',
              style:
                  textTheme.titleLarge!.copyWith(color: colorScheme.onPrimary),
            ),
            backgroundColor: colorScheme.primary,
          ),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CommonTextFeild(
                  controller: titleController,
                  title: 'Công việc cần làm',
                  hintText: 'Công việc cần làm',
                ),
                const Gap(30),
                Row(
                  children: [
                    Text(
                      'Danh mục công việc',
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    const Expanded(
                      child: SizedBox(
                        height: 50,
                        child: SelectCategory(),
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                const Row(
                  children: [
                    Expanded(child: SelectDate()),
                    Gap(10),
                    Expanded(child: SelectTime()),
                  ],
                ),
                const Gap(15),
                CommonTextFeild(
                  controller: noteController,
                  title: 'Ghi chú',
                  hintText: 'Ghi chú công việc',
                  maxLine: 6,
                ),
                const Gap(25),
                CommonButton(onPressed: _addTask, title: 'Thêm công việc'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
