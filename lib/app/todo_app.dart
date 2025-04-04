import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/category_bloc/bloc/category_bloc.dart';
import 'package:todo_app/bloc/date_bloc/bloc/date_bloc.dart';
import 'package:todo_app/bloc/task_bloc/bloc/task_bloc.dart';
import 'package:todo_app/bloc/time_bloc/bloc/time_bloc.dart';
import 'package:todo_app/data/data_source/database_provider.dart';
import 'package:todo_app/data/repository/todo_repos.dart';
import 'package:todo_app/screens/screens.dart';
import 'package:todo_app/config/config.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoReposImpl(DatabaseProvider.db),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DateBloc()..add(DateStartEvent()),
          ),
          BlocProvider(
            create: (context) => TimeBloc()..add(TimeStartEvent()),
          ),
          BlocProvider(
            create: (context) => CategoryBloc()..add(CategoryStartEvent()),
          ),
          BlocProvider(
            create: (context) => TaskBloc(context.read<TodoReposImpl>())
              ..add(TaskLoadingEvent()),
          )
        ],
        child: MaterialApp(
          themeMode: ThemeMode.light,
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
