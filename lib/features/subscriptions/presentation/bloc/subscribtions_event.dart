part of 'subscribtions_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object> get props => [];
}

class GetAllSubscribtions extends SubscriptionEvent {}
