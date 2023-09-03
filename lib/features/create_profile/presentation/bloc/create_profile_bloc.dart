import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_profile_event.dart';
part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  CreateProfileBloc() : super(CreateProfileInitial()) {
    on<CreateProfileEvent>((event, emit) {});
  }
}
