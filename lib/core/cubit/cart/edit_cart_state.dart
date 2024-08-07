part of 'edit_cart_cubit.dart';

sealed class EditCartState {}

final class EditCartInitial extends EditCartState {}

final class EditCartLoading extends EditCartState {}

final class EditCartSuccess extends EditCartState {}

final class EditCartFail extends EditCartState {}
