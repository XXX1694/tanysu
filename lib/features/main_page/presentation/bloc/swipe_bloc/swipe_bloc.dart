import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc({
    required SwipeState swipeState,
  }) : super(Bottom()) {
    on<GoTop>(
      (event, emit) {
        emit(Top());
      },
    );

    on<GoBottom>(
      (event, emit) {
        emit(Bottom());
      },
    );

    on<GoRight>(
      (event, emit) {
        emit(Right());
      },
    );

    on<GoLeft>(
      (event, emit) {
        emit(Left());
      },
    );
  }
}
