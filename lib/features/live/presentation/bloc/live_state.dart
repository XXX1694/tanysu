part of 'live_bloc.dart';

class LiveState extends Equatable {
  const LiveState();

  @override
  List<Object> get props => [];
}

class LiveInitial extends LiveState {}

class LiveCreating extends LiveState {}

class LiveCreated extends LiveState {}

class LiveCreateError extends LiveState {}

class LiveEnding extends LiveState {}

class LiveEnded extends LiveState {}

class LiveEndError extends LiveState {}
