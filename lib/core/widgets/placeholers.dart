import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShrimerPlaceholder extends StatelessWidget {
  const ShrimerPlaceholder({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade400,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }
}

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
    );
  }
}
