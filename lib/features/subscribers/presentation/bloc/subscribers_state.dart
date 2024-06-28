part of 'subscribers_bloc.dart';

class SubscribersState extends Equatable {
  const SubscribersState();

  @override
  List<Object> get props => [];
}

class SubscribersInitial extends SubscribersState {}

class GettingUsers extends SubscribersState {}

class GotUsers extends SubscribersState {
  final List<SearchResultModel> users;
  const GotUsers({required this.users});
}

class GetUsersError extends SubscribersState {}
