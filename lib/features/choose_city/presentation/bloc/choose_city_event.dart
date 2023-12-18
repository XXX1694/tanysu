part of 'choose_city_bloc.dart';

abstract class ChooseCityEvent extends Equatable {
  const ChooseCityEvent();

  @override
  List<Object> get props => [];
}

class GetAllCity extends ChooseCityEvent {}
