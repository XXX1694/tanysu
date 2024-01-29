part of 'show_gifts_bloc.dart';

abstract class ShowGiftsEvent extends Equatable {
  const ShowGiftsEvent();

  @override
  List<Object> get props => [];
}

class GetGifts extends ShowGiftsEvent {}

class SendGift extends ShowGiftsEvent {
  final int giftId;
  final int receiver;
  const SendGift({
    required this.giftId,
    required this.receiver,
  });
}
