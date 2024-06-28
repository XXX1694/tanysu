part of 'subscribers_bloc.dart';

abstract class SubscribersEvent extends Equatable {
  const SubscribersEvent();

  @override
  List<Object> get props => [];
}

class GetAllSubscribers extends SubscribersEvent {}
