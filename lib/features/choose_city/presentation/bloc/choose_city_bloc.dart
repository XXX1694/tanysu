import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/choose_city/data/models/city.dart';
import 'package:tanysu/features/choose_city/data/repositories/choose_city_repository.dart';

part 'choose_city_event.dart';
part 'choose_city_state.dart';

class ChooseCityBloc extends Bloc<ChooseCityEvent, ChooseCityState> {
  ChooseCityRepository repo;
  ChooseCityBloc({
    required this.repo,
    required ChooseCityState chooseCityState,
  }) : super(ChooseCityInitial()) {
    on<GetAllCity>(
      (event, emit) async {
        emit(CityGetting());
        try {
          List<CityModel>? res = await repo.getCitys();
          if (res != null) {
            emit(CityGot(cities: res));
          } else {
            emit(CityGetError());
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(CityGetError());
        }
      },
    );
  }
}
