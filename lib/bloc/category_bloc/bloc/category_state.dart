part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitialState extends CategoryState {}

final class CategorySelectedState extends CategoryState {
  final TaskCategory category;

  const CategorySelectedState({required this.category});

  @override
  List<Object> get props => [category];
}
