part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetUsers extends SearchEvent {
  final String? gender;
  final int? cityId;
  final int? maxAge;
  const GetUsers({
    required this.cityId,
    required this.gender,
    required this.maxAge,
  });
}
