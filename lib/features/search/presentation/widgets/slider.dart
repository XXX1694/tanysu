import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanysu/common/constants/colors.dart';

class AgeSlider extends StatefulWidget {
  const AgeSlider({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<AgeSlider> createState() => _AgeSliderState();
}

double _currentValue = 50;

class _AgeSliderState extends State<AgeSlider> {
  @override
  void initState() {
    widget.controller.text = _currentValue.round().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '18',
          style: GoogleFonts.montserrat(
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 1,
              thumbColor: mainColor,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 8),
              showValueIndicator: ShowValueIndicator.always,
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            ),
            child: Slider(
              value: _currentValue,
              thumbColor: secondColor,
              inactiveColor: mainColor50,
              activeColor: mainColor50,
              secondaryActiveColor: Colors.black12,
              min: 18,
              max: 100,
              label: _currentValue.round().toString(),
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
                widget.controller.text = _currentValue.round().toString();
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '100',
          style: GoogleFonts.montserrat(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
