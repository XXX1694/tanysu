import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/features/add_image/data/repositories/add_image_repo.dart';

part 'add_image_event.dart';
part 'add_image_state.dart';

class AddImageBloc extends Bloc<AddImageEvent, AddImageState> {
  final AddImageRepository repo;
  AddImageBloc({
    required this.repo,
    required AddImageState addImageState,
  }) : super(AddImageInitial()) {
    on<AddImage>(
      (event, emit) async {
        emit(AddingImage());
        try {
          final res =
              await repo.addImage(image: event.image, profileId: event.id);
          if (res == 201) {
            emit(AddedImage());
          } else {
            emit(AddImageError());
          }
        } catch (e) {
          emit(AddImageError());
        }
      },
    );
    on<AddImageList>(
      (event, emit) async {
        emit(AddingImage());
        try {
          bool res = true;
          await Future.forEach<String>(event.images, (item) async {
            final a = await repo.addImage(
              image: item,
              profileId: event.id,
            );
            if (a != 201) {
              res = false;
            }
          });
          // for (int i = 0; i < event.images.length; i++) {
          //   final a = await repo.addImage(
          //     image: event.images[i],
          //     profileId: event.id,
          //   );
          //   if (a != 201) {
          //     res = false;
          //   }
          // }
          if (res) {
            emit(AddedImage());
          } else {
            emit(AddImageError());
          }
        } catch (e) {
          emit(AddImageError());
        }
      },
    );

    on<DeleteImage>(
      (event, emit) async {
        try {
          final res = await repo.delete(imageId: event.id);
          if (res == 201) {
            emit(DeletedImage());
          } else {
            emit(AddImageError());
          }
        } catch (e) {
          emit(AddImageError());
        }
      },
    );

    on<ChangeImage>(
      (event, emit) async {
        try {
          final res =
              await repo.change(imageId: event.id, imageUrl: event.image);
          if (res == 201) {
            emit(ChangedImage());
          } else {
            emit(AddImageError());
          }
        } catch (e) {
          emit(AddImageError());
        }
      },
    );
  }
}
