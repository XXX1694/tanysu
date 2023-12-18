part of 'like_page_bloc.dart';

abstract class LikePageEvent extends Equatable {
  const LikePageEvent();

  @override
  List<Object> get props => [];
}

class GetLikes extends LikePageEvent {}
