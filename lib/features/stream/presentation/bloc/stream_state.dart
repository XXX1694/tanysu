part of 'stream_bloc.dart';

class StreamState extends Equatable {
  const StreamState();

  @override
  List<Object> get props => [];
}

class StreamInitial extends StreamState {}

class StreamListGetting extends StreamState {}

class StreamListGot extends StreamState {
  final List<StreamModel> streamList;
  const StreamListGot({required this.streamList});
}

class StreamListGetError extends StreamState {}
