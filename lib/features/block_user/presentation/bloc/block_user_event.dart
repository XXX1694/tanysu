part of 'block_user_bloc.dart';

abstract class BlockUserEvent extends Equatable {
  const BlockUserEvent();

  @override
  List<Object> get props => [];
}

class BlockUser extends BlockUserEvent {
  final int profileId;
  const BlockUser({required this.profileId});
}
