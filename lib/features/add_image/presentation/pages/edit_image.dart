import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/features/add_image/presentation/bloc/add_image_bloc.dart';
import 'package:tanysu/features/registration/presentation/widgets/add_picture_page/image_picker.dart';
import 'package:tanysu/l10n/translate.dart';

Future showEditImage(BuildContext context, int imageId) {
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
      );
    },
  );
}

class ImageEdit extends StatefulWidget {
  const ImageEdit({
    super.key,
    required this.imageId,
  });
  final int imageId;
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
                bloc.add(DeleteImage(id: widget.imageId));
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
