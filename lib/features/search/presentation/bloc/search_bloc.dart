import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/search/data/models/search_result_model.dart';
import 'package:tanysu/features/search/data/repositories/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository repo;
  SearchBloc({
    required this.repo,
    required SearchState searchState,
  }) : super(SearchInitial()) {
    on<GetUsers>(
      (event, emit) async {
        emit(GettingUsers());
        try {
          List<SearchResultModel> res = await repo.getUserList(
            gender: event.gender,
            maxAge: event.maxAge,
            minAge: event.minAge,
            page: event.page,
            cityId: event.cityId,
          );
          emit(GotUsers(users: res));
        } catch (e) {
          emit(GetUsersError());
        }
      },
    );
  }
}
