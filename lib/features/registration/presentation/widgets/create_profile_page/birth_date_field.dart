import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
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
    return SizedBox(
      height: 44,
      child: TextField(
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
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          hintText: translation(context).enter_birth_date,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: mainColor,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            ),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black38,
            ),
          ),
        ),
        keyboardType: TextInputType.name,
      ),
    );
  }
}
