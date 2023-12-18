part of 'juz_bloc.dart';

abstract class JuzEvent extends Equatable {
  const JuzEvent();

  @override
  List<Object> get props => [];
}

class GetAllJuz extends JuzEvent {}
