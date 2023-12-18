import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'choose_language_event.dart';
part 'choose_language_state.dart';

class ChooseLanguageBloc
    extends Bloc<ChooseLanguageEvent, ChooseLanguageState> {
  ChooseLanguageBloc() : super(ChooseLanguageInitial()) {
    on<ChooseLanguageEvent>((event, emit) {});
  }
}
