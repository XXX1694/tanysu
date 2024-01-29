import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/show_gifts/data/repositories/gift_repo.dart';

part 'show_gifts_event.dart';
part 'show_gifts_state.dart';

class ShowGiftsBloc extends Bloc<ShowGiftsEvent, ShowGiftsState> {
  final GetGiftRepository repo;
  ShowGiftsBloc({
    required this.repo,
    required,
    required ShowGiftsState showGiftsState,
  }) : super(ShowGiftsInitial()) {
    on<GetGifts>(
      (event, emit) async {
        emit(GettingGifts());
        try {
          List<dynamic>? res = await repo.getGifts();
          if (res != null) {
            emit(GotGifts(gifts: res));
          } else {
            emit(GetGiftError());
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(GetGiftError());
        }
      },
    );
    on<SendGift>(
      (event, emit) async {
        try {
          int res = await repo.sendGift(
            giftId: event.giftId,
            receiver: event.receiver,
          );
          if (res == 201) {
            emit(GiftSendSuccess());
          } else {
            emit(GiftSendError());
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
          emit(GiftSendError());
        }
      },
    );
  }
}
