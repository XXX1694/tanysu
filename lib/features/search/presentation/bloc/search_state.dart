part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class GettingUsers extends SearchState {}

class GotUsers extends SearchState {
  final List<SearchResultModel> users;
  const GotUsers({required this.users});
}

class GetUsersError extends SearchState {}
