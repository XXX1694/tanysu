part of 'stream_bloc.dart';

abstract class StreamEvent extends Equatable {
  const StreamEvent();

  @override
  List<Object> get props => [];
}

class GetAllStream extends StreamEvent {}

class UpdateAllStream extends StreamEvent {}
