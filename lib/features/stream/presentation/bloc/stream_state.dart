part of 'stream_bloc.dart';

abstract class StreamState extends Equatable {
  const StreamState();  

  @override
  List<Object> get props => [];
}
class StreamInitial extends StreamState {}
