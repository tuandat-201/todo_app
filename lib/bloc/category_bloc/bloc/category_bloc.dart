import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/data.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState()) {
    on<CategoryStartEvent>(_onCategoryStartEvent);
    on<CategorySelectedEvent>(_onCategorySelectedEvent);
  }

  Future<void> _onCategoryStartEvent(
    CategoryStartEvent event,
    Emitter<CategoryState> emit,
  ) async {
    TaskCategory category = TaskCategory.others;
    emit(CategorySelectedState(category: category));
  }

  Future<void> _onCategorySelectedEvent(
    CategorySelectedEvent event,
    Emitter<CategoryState> emit,
  ) async {
    TaskCategory category = event.category;
    emit(CategorySelectedState(category: category));
  }
}
