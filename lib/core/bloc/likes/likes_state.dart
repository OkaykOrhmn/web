part of 'likes_bloc.dart';

@immutable
sealed class LikesState {}

final class LikesInitial extends LikesState {}

final class LikesLoading extends LikesState {}

final class LikesSuccess extends LikesState {
  final List<Product> response;

  LikesSuccess({required this.response});
}

final class LikesFail extends LikesState {}
