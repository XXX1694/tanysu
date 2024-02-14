import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/l10n/translate.dart';

class GenderField extends StatefulWidget {
  const GenderField({
    super.key,
    required this.controller,
    required this.isSelected,
  });
  final TextEditingController controller;
  final String? isSelected;
  @override
  State<GenderField> createState() => _GenderFieldState();
}

String? selectedValue;

class _GenderFieldState extends State<GenderField> {
  @override
  void initState() {
    selectedValue = widget.isSelected;
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
        color: Colors.black87,
        fontSize: 14,
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
        color: Colors.black38,
      ),
      onChanged: (value) {
        setState(
          () {
            selectedValue = value!;
            if (selectedValue == translation(context).man) {
              widget.controller.text = 'male';
            } else {
              widget.controller.text = 'female';
            }
          },
        );
      },
    );
  }
}