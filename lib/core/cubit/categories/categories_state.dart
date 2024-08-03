part of 'categories_cubit.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final List<Category> response;

  CategoriesSuccess({required this.response});
}

final class CategoriesLoading extends CategoriesState {}

final class CategorieFail extends CategoriesState {}
