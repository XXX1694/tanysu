import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';

class GenderField extends StatefulWidget {
  const GenderField({
    super.key,
    required this.controller,
    required this.selctedGender,
  });
  final TextEditingController controller;
  final String? selctedGender;
  @override
  State<GenderField> createState() => _GenderFieldState();
}

String? selectedValue;

class _GenderFieldState extends State<GenderField> {
  @override
  void initState() {
    selectedValue = widget.selctedGender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownList = [
      translation(context).man,
      translation(context).woman,
    ];
    return DropdownButton<String>(
      value: selectedValue,
      style: GoogleFonts.montserrat(
        color: Colors.black.withOpacity(0.7),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      hint: Text(translation(context).choose_gender),
      isExpanded: true,
      items: dropdownList.map(
        (String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      borderRadius: BorderRadius.circular(8),
      elevation: 1,
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
          if (selectedValue == translation(context).man) {
            widget.controller.text = 'male';
          } else {
            widget.controller.text = 'female';
          }
        });
      },
    );
  }
}
