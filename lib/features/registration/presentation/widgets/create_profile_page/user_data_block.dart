import 'package:flutter/material.dart';
import 'package:tanysu/features/choose_city/presentation/widgets/city_field.dart';

import 'birth_date_field.dart';
import 'first_name_field.dart';
import 'gender_field.dart';

class UserDataBlock extends StatelessWidget {
  const UserDataBlock({
    super.key,
    required this.birthDateController,
    required this.cityController,
    required this.genderController,
    required this.nameController,
  });
  final TextEditingController nameController;
  final TextEditingController birthDateController;
  final TextEditingController genderController;
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FirstNameField(controller: nameController),
        const SizedBox(height: 20),
        BirthDateField(
          controller: birthDateController,
          date: null,
        ),
        const SizedBox(height: 20),
        GenderField(
          controller: genderController,
          isSelected: null,
        ),
        const SizedBox(height: 20),
        CityField(
          controller: cityController,
        ),
      ],
    );
  }
}
