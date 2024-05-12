import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../l10n/translate.dart';
import '../../../../../core/constants/colors.dart';

var formatter = DateFormat('dd/MM/yyyy');

class BirthDateField extends StatefulWidget {
  const BirthDateField({
    super.key,
    required this.controller,
    required this.date,
  });
  final TextEditingController controller;
  final DateTime? date;

  @override
  State<BirthDateField> createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime.now().subtract(const Duration(days: 365 * 100)),
          maxTime: DateTime.now().subtract(const Duration(days: 6574)),
          onChanged: (date) {},
          onConfirm: (date) {
            setState(
              () {
                widget.controller.text =
                    DateFormat('yyyy-MM-dd').format(date).toString();
              },
            );
          },
          currentTime: widget.date ?? DateTime.now(),
        );
      },
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: translation(context).enter_birth_date,
        hintStyle: GoogleFonts.montserrat(
          color: Colors.black54,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: secondColor,
          ),
        ),
      ),
      keyboardType: TextInputType.name,
    );
  }
}
