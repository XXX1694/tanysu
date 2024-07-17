import 'package:flutter/material.dart';

import 'package:tanysu/core/constants/colors.dart';

class AgeSlider extends StatefulWidget {
  const AgeSlider({
    super.key,
    required this.maxAgeController,
    required this.minAgeController,
  });
  final TextEditingController maxAgeController;
  final TextEditingController minAgeController;
  @override
  State<AgeSlider> createState() => _AgeSliderState();
}

double maxAge = 35;
double minAge = 18;
var selectRange = const RangeValues(21, 35);

class _AgeSliderState extends State<AgeSlider> {
  @override
  void initState() {
    widget.maxAgeController.text = maxAge.round().toString();
    widget.minAgeController.text = minAge.round().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '18',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.black54,
              ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SliderTheme(
            data: const SliderThemeData(
              trackHeight: 1,
              thumbColor: mainColor,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 6),
              showValueIndicator: ShowValueIndicator.always,
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            ),
            child: RangeSlider(
              // thumbColor: secondColor,
              inactiveColor: mainColor50,
              activeColor: mainColor,
              // secondaryActiveColor: Colors.black12,
              overlayColor: const WidgetStatePropertyAll(secondColor),
              min: 18,
              max: 65,
              labels: RangeLabels(
                selectRange.start.round().toString(),
                selectRange.end.round().toString(),
              ),
              // label: _currentValue.round().toString(),
              // onChanged: (value) {
              //   setState(() {
              //     _currentValue = value;
              //   });
              //   widget.controller.text = _currentValue.round().toString();
              // },
              values: selectRange,
              onChanged: (RangeValues value) {
                widget.maxAgeController.text = value.end.round().toString();
                widget.minAgeController.text = value.start.round().toString();
                setState(() {
                  selectRange = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '65',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.black54,
              ),
        ),
      ],
    );
  }
}
