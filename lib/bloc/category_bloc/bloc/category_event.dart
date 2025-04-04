part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

final class CategoryStartEvent extends CategoryEvent {}

final class CategorySelectedEvent extends CategoryEvent {
  final TaskCategory category;

  const CategorySelectedEvent({required this.category});
}
