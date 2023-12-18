part of 'choose_city_bloc.dart';

class ChooseCityState extends Equatable {
  const ChooseCityState();

  @override
  List<Object> get props => [];
}

class ChooseCityInitial extends ChooseCityState {}

class CityGetting extends ChooseCityState {}

class CityGot extends ChooseCityState {
  final List<CityModel> cities;
  const CityGot({required this.cities});
}

class CityGetError extends ChooseCityState {}
