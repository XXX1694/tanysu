part of 'add_image_bloc.dart';

abstract class AddImageEvent extends Equatable {
  const AddImageEvent();

  @override
  List<Object> get props => [];
}

class AddImage extends AddImageEvent {
  final String image;
  final int id;
  const AddImage({
    required this.image,
    required this.id,
  });
}

class AddImageList extends AddImageEvent {
  final List<String> images;
  final int id;
  const AddImageList({
    required this.images,
    required this.id,
  });
}

class DeleteImage extends AddImageEvent {
  final int id;
  const DeleteImage({
    required this.id,
  });
}

class ChangeImage extends AddImageEvent {
  final int id;
  final String image;
  const ChangeImage({
    required this.id,
    required this.image,
  });
}
