import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/search/data/models/search_result_model.dart';
import 'package:tanysu/features/subscribers/data/repositories/subscribers_repository.dart';

part 'subscribers_event.dart';
part 'subscribers_state.dart';

class SubscribersBloc extends Bloc<SubscribersEvent, SubscribersState> {
  final SubscribersRepository repository;
  SubscribersBloc({
    required this.repository,
    required SubscribersState subscribersState,
  }) : super(SubscribersInitial()) {
    on<GetAllSubscribers>(
      (event, emit) async {
        emit(GettingUsers());
        List<SearchResultModel> users = await repository.getSunscribersList();
        if (users.isEmpty) {
          emit(GetUsersError());
        } else {
          emit(GotUsers(users: users));
        }
      },
    );
  }
}
