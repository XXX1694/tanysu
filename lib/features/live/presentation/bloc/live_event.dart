// ignore_for_file: non_constant_identifier_names

part of 'live_bloc.dart';

abstract class LiveEvent extends Equatable {
  const LiveEvent();

  @override
  List<Object> get props => [];
}

class CreateLive extends LiveEvent {
  final String stream_id;
  const CreateLive({required this.stream_id});
}

class EndLive extends LiveEvent {
  final String stream_id;
  const EndLive({required this.stream_id});
}
