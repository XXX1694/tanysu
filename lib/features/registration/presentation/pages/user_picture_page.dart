import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanysu/common/functions/show_snack_bar.dart';
import 'package:tanysu/common/widgets/main_button_filled.dart';
import 'package:tanysu/features/add_image/presentation/bloc/add_image_bloc.dart';
import 'package:tanysu/features/login/presentation/bloc/login_bloc.dart';
import 'package:tanysu/features/registration/presentation/bloc/registration_bloc/registration_bloc.dart';

import 'package:tanysu/l10n/translate.dart';

import '../widgets/add_picture_page/photos_block.dart';
import '../widgets/add_picture_page/pic_main_text.dart';

class UserPicturePage extends StatefulWidget {
  const UserPicturePage({
    super.key,
    required this.birthday,
    required this.city,
    required this.email,
    required this.gender,
    required this.name,
    required this.password,
    required this.tryToFind,
  });
  final String email;
  final String password;
  final String name;
  final String birthday;
  final String gender;
  final String city;
  final String tryToFind;
  @override
  State<UserPicturePage> createState() => _UserPicturePageState();
}

class _UserPicturePageState extends State<UserPicturePage> {
  late TextEditingController path1;
  late TextEditingController path2;
  late TextEditingController path3;
  late TextEditingController path4;
  late RegistrationBloc registrationBloc;
  late LoginBloc loginBloc;
  late AddImageBloc addImageBloc;
  List<String> images = [];
  @override
  void initState() {
    images = [];
    path1 = TextEditingController();
    path2 = TextEditingController();
    path3 = TextEditingController();
    path4 = TextEditingController();
    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    addImageBloc = BlocProvider.of<AddImageBloc>(context);
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  PicMainText(),
                  // SizedBox(height: 22),
                  // PicSecondText(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PhotosBlock(
                  path: [
                    path1,
                    path2,
                    path3,
                    path4,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: BlocConsumer<AddImageBloc, AddImageState>(
                builder: (context, state1) =>
                    BlocConsumer<RegistrationBloc, RegistrationState>(
                  builder: (context, state) {
                    if (state is UserCreating) {
                      return const MainButtonFilledLoading();
                    } else {
                      return MainButtonFilled(
                        text: translation(context).next,
                        onPressed: () {
                          path1.text.isNotEmpty ? images.add(path1.text) : null;
                          path2.text.isNotEmpty ? images.add(path2.text) : null;
                          path3.text.isNotEmpty ? images.add(path3.text) : null;
                          path4.text.isNotEmpty ? images.add(path4.text) : null;
                          images.length <= 1
                              ? showSnackBar(
                                  context, translation(context).pic_second_text)
                              : registrationBloc.add(
                                  CreateUser(
                                    email: widget.email,
                                    password: widget.password,
                                    birthDate: widget.birthday,
                                    city: int.parse(widget.city),
                                    gender: widget.gender,
                                    name: widget.name,
                                    tryToFind: widget.tryToFind,
                                  ),
                                );
                        },
                      );
                    }
                  },
                  listener: (context, state) {
                    if (state is UserCreateError) {
                      showSnackBar(context, state.error);
                    } else if (state is UserCreated) {
                      addImageBloc.add(
                        AddImageList(
                          images: images,
                          id: state.profileId,
                        ),
                      );
                    }
                  },
                ),
                listener: (context, state1) {
                  if (state1 is AddedImage) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/choose', (route) => false);
                    loginBloc.add(
                      LogIn(
                        email: widget.email,
                        password: widget.password,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    path1.dispose();
    path2.dispose();
    path3.dispose();
    path4.dispose();
    super.dispose();
  }
}
