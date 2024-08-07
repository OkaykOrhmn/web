part of 'like_cubit.dart';

class LikeState {}

final class LikeInitial extends LikeState {}

final class LikeLoading extends LikeState {}

final class LikeSuccess extends LikeState {
  final bool response;

  LikeSuccess({required this.response});
}

final class LikeFail extends LikeState {}
