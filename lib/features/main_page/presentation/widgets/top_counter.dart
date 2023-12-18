import 'package:flutter/material.dart';

class TopCounter extends StatelessWidget {
  const TopCounter({super.key, required this.count, required this.controller});
  final int count;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        count,
        (index) => Expanded(
          child: Container(
            margin: controller.text == '0'
                ? const EdgeInsets.only(right: 5)
                : const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: controller.text == index.toString()
                  ? Colors.white
                  : Colors.white30,
              borderRadius: BorderRadius.circular(100),
            ),
            height: 4,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
