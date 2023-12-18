part of 'like_page_bloc.dart';

class LikePageState extends Equatable {
  const LikePageState();

  @override
  List<Object> get props => [];
}

class LikePageInitial extends LikePageState {}

class LikeGetting extends LikePageState {}

class LikeGot extends LikePageState {
  final List<LikePersonModel> likesMe;
  final List<LikePersonModel> meLike;
  const LikeGot({required this.likesMe, required this.meLike});
}

class LikeGetError extends LikePageState {}
