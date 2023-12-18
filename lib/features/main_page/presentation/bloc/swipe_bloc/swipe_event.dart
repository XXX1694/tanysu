part of 'swipe_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object> get props => [];
}

class GoTop extends SwipeEvent {}

class GoLeft extends SwipeEvent {}

class GoRight extends SwipeEvent {}

class GoBottom extends SwipeEvent {}
