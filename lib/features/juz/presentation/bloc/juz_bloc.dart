import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/juz/data/models/juz_model.dart';
import 'package:tanysu/features/juz/data/repositories/juz_repository.dart';

part 'juz_event.dart';
part 'juz_state.dart';

class JuzBloc extends Bloc<JuzEvent, JuzState> {
  final JuzRepository repo;
  JuzBloc({
    required this.repo,
    required JuzState juzState,
  }) : super(JuzInitial()) {
    on<GetAllJuz>(
      (event, emit) async {
        emit(JuzGetting());
        try {
          List<JuzModel>? res = await repo.juzGet();
          if (res != null) {
            emit(JuzGot(juz: res));
          } else {
            emit(JuzGetError());
          }
        } catch (e) {
          emit(JuzGetError());
        }
      },
    );
  }
}
