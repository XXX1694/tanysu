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
  final int? minAge;
  final int page;
  const GetUsers({
    required this.cityId,
    required this.minAge,
    required this.gender,
    required this.maxAge,
    required this.page,
  });
}
