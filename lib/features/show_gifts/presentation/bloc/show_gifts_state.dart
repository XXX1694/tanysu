part of 'show_gifts_bloc.dart';

class ShowGiftsState extends Equatable {
  const ShowGiftsState();

  @override
  List<Object> get props => [];
}

class ShowGiftsInitial extends ShowGiftsState {}

class GettingGifts extends ShowGiftsState {}

class GotGifts extends ShowGiftsState {
  final List<dynamic> gifts;
  const GotGifts({required this.gifts});
}

class GetGiftError extends ShowGiftsState {}
