import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainButtonIcon extends StatelessWidget {
  const MainButtonIcon({
    super.key,
    required this.text,
    required this.onPressed,
    required this.icon,
  });
  final String text;
  final String icon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          children: [
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 13),
                  SvgPicture.asset(
                    icon,
                    height: 24,
                    width: 24,
                    color: Colors.black,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
