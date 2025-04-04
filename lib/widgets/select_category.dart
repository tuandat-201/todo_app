import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/widgets/widgets.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategorySelectedState) {
          final currentCategory = state.category;

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: TaskCategory.values.length,
            itemBuilder: (context, index) {
              TaskCategory category = TaskCategory.values[index];

              return GestureDetector(
                onTap: () {
                  context
                      .read<CategoryBloc>()
                      .add(CategorySelectedEvent(category: category));
                },
                child: IconContainer(
                  category: category,
                  size: category == currentCategory ? 60 : 40,
                ),
              );
            },
            separatorBuilder: (context, index) => const Gap(5),
          );
        } else {
          return const Placeholder();
        }
      },
    );
  }
}
