part of 'block_user_bloc.dart';

class BlockUserState extends Equatable {
  const BlockUserState();

  @override
  List<Object> get props => [];
}

class BlockUserInitial extends BlockUserState {}

class UserBlocking extends BlockUserState {}

class UserBlocked extends BlockUserState {}

class UserUnBlocked extends BlockUserState {}

class UserBlockError extends BlockUserState {}
