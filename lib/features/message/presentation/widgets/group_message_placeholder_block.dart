import 'package:flutter/material.dart';
import 'package:tanysu/core/widgets/placeholers.dart';

class GroupMessageBlockPlaceholder extends StatelessWidget {
  const GroupMessageBlockPlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(),
        SizedBox(height: 8),
        MyMessage(
          height: 40,
          width: 140,
        ),
        SizedBox(height: 8),
        OtherMessage(
          height: 80,
          width: 100,
        ),
        SizedBox(height: 8),
        OtherMessage(
          height: 40,
          width: 130,
        ),
        SizedBox(height: 8),
        OtherMessage(
          height: 40,
          width: 240,
        ),
        SizedBox(height: 8),
        OtherMessage(
          height: 40,
          width: 170,
        ),
        SizedBox(height: 8),
        MyMessage(
          height: 40,
          width: 140,
        ),
        SizedBox(height: 8),
        OtherMessage(
          height: 80,
          width: 100,
        ),
        SizedBox(height: 8),
        OtherMessage(
          height: 40,
          width: 130,
        ),
        SizedBox(height: 8),
        MyMessage(
          height: 40,
          width: 90,
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class MyMessage extends StatelessWidget {
  const MyMessage({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Row(
        children: [
          const Spacer(),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(2, 2),
                  blurRadius: 15,
                ),
              ],
            ),
            child: const ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(0),
              ),
              child: ShrimerPlaceholder(
                height: 40,
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OtherMessage extends StatelessWidget {
  const OtherMessage({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 4),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.shade400,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const ShrimerPlaceholder(
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(2, 2),
                  blurRadius: 15,
                ),
              ],
            ),
            child: const ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: ShrimerPlaceholder(
                height: 70,
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
