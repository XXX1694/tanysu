import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/search/data/models/search_result_model.dart';
import 'package:tanysu/features/subscriptions/data/repositories/subscribtions_repository.dart';

part 'subscribtions_event.dart';
part 'subscribtions_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository repository;
  SubscriptionBloc({
    required this.repository,
    required SubscriptionState subscribersState,
  }) : super(SubscriptionsInitial()) {
    on<GetAllSubscribtions>(
      (event, emit) async {
        emit(GettingUsers());
        List<SearchResultModel> users = await repository.getSunscribtionsList();
        if (users.isEmpty) {
          emit(GetUsersError());
        } else {
          emit(GotUsers(users: users));
        }
      },
    );
  }
}
