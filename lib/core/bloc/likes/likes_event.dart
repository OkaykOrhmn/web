part of 'likes_bloc.dart';

@immutable
sealed class LikesEvent {}

class GetAllLikes extends LikesEvent {}
