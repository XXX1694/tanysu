import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_ferify_event.dart';
part 'user_ferify_state.dart';

class UserFerifyBloc extends Bloc<UserFerifyEvent, UserFerifyState> {
  UserFerifyBloc() : super(UserFerifyInitial()) {
    on<UserFerifyEvent>((event, emit) {});
  }
}
