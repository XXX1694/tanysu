part of 'subscribtions_bloc.dart';

class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

class SubscriptionsInitial extends SubscriptionState {}

class GettingUsers extends SubscriptionState {}

class GotUsers extends SubscriptionState {
  final List<SearchResultModel> users;
  const GotUsers({required this.users});
}

class GetUsersError extends SubscriptionState {}
