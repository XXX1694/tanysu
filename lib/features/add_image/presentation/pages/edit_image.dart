import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/functions/show_snack_bar.dart';
import 'package:tanysu/features/add_image/presentation/bloc/add_image_bloc.dart';
import 'package:tanysu/features/registration/presentation/widgets/add_picture_page/image_picker.dart';
import 'package:tanysu/l10n/translate.dart';

Future showEditImage(
  BuildContext context,
  int imageId,
  bool last,
) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return ImageEdit(
        imageId: imageId,
        last: last,
      );
    },
  );
}

Future showEditImageIOS(
  BuildContext context,
  int imageId,
  bool last,
) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CuprtinoActionSheetBuilder(
        imageId: imageId,
        last: last,
      );
    },
  );
}

class CuprtinoActionSheetBuilder extends StatefulWidget {
  const CuprtinoActionSheetBuilder({
    super.key,
    required this.imageId,
    required this.last,
  });
  final int imageId;
  final bool last;
  @override
  State<CuprtinoActionSheetBuilder> createState() =>
      _CuprtinoActionSheetBuilderState();
}

class _CuprtinoActionSheetBuilderState
    extends State<CuprtinoActionSheetBuilder> {
  late AddImageBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AddImageBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddImageBloc, AddImageState>(
      builder: (context, state) => CupertinoActionSheet(
        title: Text(
          translation(context).edit_photo,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        message: Text(translation(context).edit_photo_second),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              final imageUrl = await pickUploadImage();
              if (imageUrl != null) {
                bloc.add(ChangeImage(id: widget.imageId, image: imageUrl));
              }
            },
            child: Text(translation(context).change_image),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              if (widget.last) {
                Navigator.pop(context);
                showSnackBar(context, translation(context).at_least_one_image);
              } else {
                bloc.add(DeleteImage(id: widget.imageId));
              }
            },
            child: Text(translation(context).delete_image),
          ),
        ],
      ),
      listener: (context, state) {
        Navigator.pop(context);
      },
    );
  }
}

class ImageEdit extends StatefulWidget {
  const ImageEdit({
    super.key,
    required this.imageId,
    required this.last,
  });
  final int imageId;
  final bool last;
  @override
  State<ImageEdit> createState() => _ImageEditState();
}

class _ImageEditState extends State<ImageEdit> {
  late AddImageBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AddImageBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddImageBloc, AddImageState>(
      builder: (context, state) => Container(
        height: 203 - 44,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(35, 35, 35, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              child: Text(
                translation(context).change_image,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () async {
                final imageUrl = await pickUploadImage();
                if (imageUrl != null) {
                  bloc.add(ChangeImage(id: widget.imageId, image: imageUrl));
                }
              },
            ),
            const SizedBox(height: 4),
            const Divider(color: Colors.black26),
            const SizedBox(height: 4),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              child: Text(
                translation(context).delete_image,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                if (widget.last) {
                  Navigator.pop(context);
                  showSnackBar(
                      context, translation(context).at_least_one_image);
                } else {
                  bloc.add(DeleteImage(id: widget.imageId));
                }
              },
            ),
          ],
        ),
      ),
      listener: (context, state) {
        Navigator.pop(context);
      },
    );
  }
}
