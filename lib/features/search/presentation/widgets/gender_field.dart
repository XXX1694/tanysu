import 'package:flutter/material.dart';
import 'package:tanysu/l10n/translate.dart';

class GenderField extends StatefulWidget {
  const GenderField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  State<GenderField> createState() => _GenderFieldState();
}

String? selectedValue;

class _GenderFieldState extends State<GenderField> {
  @override
  void initState() {
    // selectedValue = widget.controller.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropdownList = [
      translation(context).man,
      translation(context).woman,
    ];
    if (widget.controller.text == translation(context).man) {
      selectedValue = dropdownList[0];
    } else if (widget.controller.text == translation(context).woman) {
      selectedValue = dropdownList[1];
    }

    return DropdownButton<String>(
      value: selectedValue,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black,
          ),
      hint: Text(
        translation(context).choose_gender,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black54,
            ),
      ),
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
