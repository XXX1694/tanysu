// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/constants/colors.dart';
import 'package:tanysu/core/functions/show_snack_bar.dart';
import 'package:tanysu/core/widgets/main_button.dart';
import 'package:tanysu/core/widgets/placeholers.dart';
import 'package:tanysu/features/add_image/presentation/bloc/add_image_bloc.dart';
import 'package:tanysu/features/add_image/presentation/pages/edit_image.dart';
import 'package:tanysu/features/choose_city/presentation/widgets/city_field_mine.dart';

import 'package:tanysu/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:tanysu/features/edit_profile/presentation/widgets/juz_field.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/about_me_widgets/about_me_field.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/job_page_widgets/company_field.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/job_page_widgets/job_field.dart';
import 'package:tanysu/features/profile_add_info/presentation/widgets/school_page_widgets/school_page_field.dart';
import 'package:tanysu/features/profile_page/presentation/bloc/profile_page_bloc.dart';
import 'package:tanysu/features/profile_preview/data/models/profile_model.dart';
import 'package:tanysu/features/profile_preview/presentation/pages/profile_preview_page_mine.dart';
import 'package:tanysu/features/registration/presentation/widgets/add_picture_page/image_picker.dart';
import 'package:tanysu/features/registration/presentation/widgets/create_profile_page/birth_date_field.dart';
import 'package:tanysu/features/registration/presentation/widgets/create_profile_page/first_name_field.dart';
import 'package:tanysu/features/search/presentation/widgets/gender_field.dart';
import 'package:tanysu/l10n/translate.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController birthDateController;
  late TextEditingController genderController;
  late TextEditingController cityController;
  late TextEditingController cityIdController;
  late TextEditingController jobController;
  late TextEditingController companyController;
  late TextEditingController schoolController;
  late TextEditingController aboutMeController;
  late TextEditingController tryToFindController;
  late TextEditingController juzController;
  late EditProfileBloc bloc;
  late ProfilePageBloc bloc1;
  late AddImageBloc bloc2;
  late List<Map<String, dynamic>> images = [];
  @override
  void initState() {
    cityIdController = TextEditingController();
    bloc = BlocProvider.of<EditProfileBloc>(context);
    bloc1 = BlocProvider.of<ProfilePageBloc>(context);
    bloc2 = BlocProvider.of<AddImageBloc>(context);
    nameController = TextEditingController();
    birthDateController = TextEditingController();
    genderController = TextEditingController();
    cityController = TextEditingController();
    jobController = TextEditingController();
    companyController = TextEditingController();
    schoolController = TextEditingController();
    aboutMeController = TextEditingController();
    tryToFindController = TextEditingController();
    juzController = TextEditingController();

    bloc1.add(GetMyData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageBloc, ProfilePageState>(
      listener: (context, state) {
        if (state is ProfileGot) {
          // debugPrint(state.model.gender);
          // debugPrint(state.model.try_to_find);
          debugPrint(state.model.juz);
          images = state.model.images!;
          images.add({'id': 'fafa'});
          cityIdController.text = state.model.city.toString();
          nameController.text = state.model.first_name ?? '';
          birthDateController.text = state.model.birth_date ?? '';
          genderController.text = state.model.gender == 'male'
              ? translation(context).man
              : translation(context).woman;
          cityController.text = state.model.city_name.toString();
          jobController.text = state.model.profession ?? '';
          companyController.text = state.model.company_name ?? '';
          schoolController.text = state.model.school_name ?? '';
          aboutMeController.text = state.model.about_me ?? '';
          juzController.text = state.model.juz ?? '';
          tryToFindController.text = state.model.try_to_find == 'male'
              ? translation(context).man
              : translation(context).woman;
        }
      },
      builder: (context, state) {
        if (state is ProfileGot) {
          return BlocConsumer<AddImageBloc, AddImageState>(
            listener: (context, state1) {
              bloc1.add(GetMyData());
              if (state1 is AddedImage) {
                AwesomeNotifications().createNotification(
                  content: NotificationContent(
                    id: 10,
                    channelKey: 'basic_channel',
                    title: 'Tanysu',
                    body: translation(context).image_uploaded,
                  ),
                );
              }
            },
            builder: (context, state1) =>
                BlocConsumer<EditProfileBloc, EditProfileState>(
              builder: (context, state2) => Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const GradientText(
                    'Tanysu',
                    gradient: LinearGradient(
                      colors: <Color>[
                        mainColor,
                        secondColor,
                      ],
                    ),
                  ),
                  centerTitle: true,
                  foregroundColor: Colors.black,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    GestureDetector(
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/eye.svg',
                          height: 24,
                          width: 24,
                        ),
                      ),
                      onTap: () {
                        List<Map<String, dynamic>> img =
                            state.model.images ?? [];
                        img.removeLast();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePreviewPageMine(
                              profile: ProfileModel(
                                state.model.is_liked,
                                state.model.id,
                                img,
                                state.model.age,
                                cityController.text,
                                nameController.text,
                                state.model.tags,
                                aboutMeController.text,
                                birthDateController.text,
                                state.model.city,
                                companyController.text,
                                state.model.followers_count,
                                genderController.text,
                                state.model.is_verified,
                                state.model.matched,
                                jobController.text,
                                state.model.reason,
                                schoolController.text,
                                tryToFindController.text,
                                state.model.user,
                                0,
                                juzController.text,
                                0,
                                false,
                                state.model.following_count,
                                state.model.new_likes,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        CarouselSlider(
                          items: images
                              .map(
                                (e) => CupertinoButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () async {
                                    if (e['id'] == 'fafa') {
                                      String imageUrl;
                                      imageUrl = await pickUploadImage();
                                      images.add({'image_url': imageUrl});

                                      bloc2.add(
                                        AddImage(
                                          image: imageUrl,
                                          id: state.model.id ?? 0,
                                        ),
                                      );
                                    } else {
                                      showEditImageIOS(
                                        context,
                                        e['id'],
                                        images.length <= 2 ? true : false,
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: e == images[images.length - 1]
                                          ? Colors.black12
                                          : Colors.transparent,
                                    ),
                                    width: 310,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: e != images[images.length - 1]
                                          ? CachedNetworkImage(
                                              imageUrl: e['image_url'],
                                              alignment: Alignment.topCenter,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const ShrimerPlaceholder(
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const ErrorPlaceholder(
                                                height: double.infinity,
                                                width: double.infinity,
                                              ),
                                            )
                                          : Center(
                                              child: SvgPicture.asset(
                                                'assets/icons/add.svg',
                                                height: 150,
                                                width: 150,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 405,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${state.model.first_name}, ${state.model.age}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(width: 12),
                            SvgPicture.asset(
                              'assets/icons/not_verified.svg',
                              height: 34,
                              width: 34,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FirstNameField(controller: nameController),
                              const SizedBox(height: 20),
                              BirthDateField(
                                controller: birthDateController,
                                date: state.model.birth_date != null
                                    ? DateTime.parse(state.model.birth_date!)
                                    : null,
                              ),
                              const SizedBox(height: 20),
                              GenderField(controller: genderController),
                              const SizedBox(height: 20),
                              CityField(
                                controller: cityController,
                                cityId: state.model.city,
                                controllerId: cityIdController,
                              ),
                              const SizedBox(height: 20),
                              JobField(controller: jobController),
                              const SizedBox(height: 20),
                              CompanyField(controller: companyController),
                              const SizedBox(height: 20),
                              SchoolPageField(controller: schoolController),
                              const SizedBox(height: 20),
                              AboutMeField(controller: aboutMeController),
                              const SizedBox(height: 28),
                              const Divider(color: Colors.black26, height: 1),
                              const SizedBox(height: 28),
                              Text(
                                translation(context).try_to_find,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Colors.black54,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              GenderField(controller: tryToFindController),
                              const SizedBox(height: 20),
                              Text(
                                translation(context).juz_main_text,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Colors.black54,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              JuzField(controller: juzController),
                              const SizedBox(height: 60),
                              MainButton(
                                text: translation(context).confirm,
                                onPressed: () {
                                  bloc.add(
                                    UpdateProfile(
                                      about: aboutMeController.text == ''
                                          ? null
                                          : aboutMeController.text,
                                      birthDate: birthDateController.text == ''
                                          ? null
                                          : birthDateController.text,
                                      city: int.parse(cityIdController.text),
                                      company: companyController.text == ''
                                          ? null
                                          : companyController.text,
                                      gender: genderController.text ==
                                              translation(context).man
                                          ? 'male'
                                          : 'female',
                                      job: jobController.text == ''
                                          ? null
                                          : jobController.text,
                                      name: nameController.text,
                                      profileId: state.model.id,
                                      school: schoolController.text == ''
                                          ? null
                                          : schoolController.text,
                                      juz: juzController.text == ''
                                          ? null
                                          : juzController.text,
                                      tryToFind: tryToFindController.text ==
                                              translation(context).man
                                          ? 'male'
                                          : 'female',
                                    ),
                                  );
                                },
                                status: 'active',
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              listener: (context, state) {
                if (state is ProfileUpdated) {
                  Navigator.pop(context);
                  bloc1.add(GetMyData());
                } else if (state is ProfileUpdateError) {
                  Navigator.pop(context);
                  showSnackBar(
                    context,
                    text: translation(context).success_t,
                  );
                }
              },
            ),
          );
        } else if (state is ProfileGetting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator(
                      color: mainColor,
                      strokeWidth: 3,
                    )
                  : const CupertinoActivityIndicator(
                      color: mainColor,
                    ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(translation(context).error),
            ),
          );
        }
      },
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;

  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserratAlternates(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
