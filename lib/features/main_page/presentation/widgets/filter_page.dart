import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/core/widgets/main_button_filled.dart';
import 'package:tanysu/features/choose_city/presentation/widgets/city_field.dart';
import 'package:tanysu/features/search/presentation/widgets/gender_field.dart';
import 'package:tanysu/features/search/presentation/widgets/slider.dart';
import 'package:tanysu/l10n/translate.dart';

class MainFilterPage extends StatefulWidget {
  const MainFilterPage({super.key});

  @override
  State<MainFilterPage> createState() => _MainFilterPageState();
}

class _MainFilterPageState extends State<MainFilterPage> {
  late TextEditingController _cityController;
  late TextEditingController _genderController;
  late TextEditingController _minAgeController;
  late TextEditingController _maxAgeController;

  @override
  void initState() {
    _cityController = TextEditingController();
    _genderController = TextEditingController();
    _minAgeController = TextEditingController();
    _maxAgeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          translation(context).filter,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.black12,
            width: double.infinity,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                translation(context).city,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              CityField(
                controller: _cityController,
              ),
              const SizedBox(height: 24),
              Text(
                translation(context).try_to_find,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              GenderField(
                controller: _genderController,
                // selctedGender: '',
              ),
              const SizedBox(height: 24),
              Text(
                translation(context).age,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              AgeSlider(
                maxAgeController: _maxAgeController,
                minAgeController: _minAgeController,
              ),
              const Spacer(),
              MainButtonFilled(
                text: translation(context).search,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }
}
