import 'package:flutter/material.dart';
import 'package:tanysu/features/user_verify/presentation/widgets/verification_icon.dart';

class NameBlock extends StatelessWidget {
  const NameBlock({
    super.key,
    required this.name,
    required this.age,
  });
  final String name;
  final int age;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$name, $age',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
              ),
        ),
        const SizedBox(width: 12),
        const VerificationIcon(),
      ],
    );
  }
}
