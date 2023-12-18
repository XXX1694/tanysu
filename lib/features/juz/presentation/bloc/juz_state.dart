part of 'juz_bloc.dart';

class JuzState extends Equatable {
  const JuzState();

  @override
  List<Object> get props => [];
}

class JuzInitial extends JuzState {}

class JuzGetting extends JuzState {}

class JuzGot extends JuzState {
  final List<JuzModel> juz;
  const JuzGot({required this.juz});
}

class JuzGetError extends JuzState {}
