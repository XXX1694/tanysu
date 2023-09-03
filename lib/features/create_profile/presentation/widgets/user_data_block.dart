import 'package:flutter/material.dart';
import 'package:tanysu/features/create_profile/presentation/widgets/birth_date_field.dart';
import 'package:tanysu/features/create_profile/presentation/widgets/city_field.dart';
import 'package:tanysu/features/create_profile/presentation/widgets/first_name_field.dart';
import 'package:tanysu/features/create_profile/presentation/widgets/gender_field.dart';

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
        BirthDateField(controller: birthDateController),
        const SizedBox(height: 20),
        GenderField(controller: genderController),
        const SizedBox(height: 20),
        CityField(controller: cityController),
      ],
    );
  }
}
