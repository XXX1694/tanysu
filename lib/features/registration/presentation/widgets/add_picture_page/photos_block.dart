import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/features/registration/presentation/widgets/add_picture_page/image_picker.dart';

class PhotosBlock extends StatefulWidget {
  const PhotosBlock({
    required this.path,
    super.key,
  });
  final List<TextEditingController> path;

  @override
  State<PhotosBlock> createState() => _PhotosBlockState();
}

class _PhotosBlockState extends State<PhotosBlock> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.path.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 15 / 20,
      ),
      itemBuilder: (context, index) => SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            strokeWidth: 1,
                            dashPattern: const [5, 5],
                            radius: const Radius.circular(10),
                            padding: const EdgeInsets.all(0),
                            color: mainColor50,
                            child: widget.path[index].text.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.file(
                                      File(widget.path[index].text),
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () async {
                  if (widget.path[index].text.isEmpty) {
                    widget.path[index].text = await pickUploadImage();
                    setState(() {});
                  } else {
                    widget.path[index].text = '';
                    setState(() {});
                  }
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: widget.path[index].text.isEmpty
                        ? mainColor
                        : accentColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      widget.path[index].text.isEmpty
                          ? 'assets/icons/select.svg'
                          : 'assets/icons/cancel_new.svg',
                      // ignore: deprecated_member_use
                      color: widget.path[index].text.isEmpty
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
