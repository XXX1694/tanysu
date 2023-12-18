part of 'main_page_bloc.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class GetUsers extends MainPageEvent {}

class GetMoreUsers extends MainPageEvent {}

class Like extends MainPageEvent {
  final int profileId;
  const Like({required this.profileId});
}

class DisLike extends MainPageEvent {
  final int profileId;
  const DisLike({required this.profileId});
}

class UnLike extends MainPageEvent {
  final int profileId;
  const UnLike({required this.profileId});
}
