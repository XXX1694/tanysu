part of 'add_image_bloc.dart';

class AddImageState extends Equatable {
  const AddImageState();

  @override
  List<Object> get props => [];
}

class AddImageInitial extends AddImageState {}

class AddingImage extends AddImageState {}

class AddedImage extends AddImageState {}

class DeletedImage extends AddImageState {}

class ChangedImage extends AddImageState {}

class AddImageError extends AddImageState {}
