import 'package:flutter/material.dart';

class StreamListPlaceholer extends StatelessWidget {
  const StreamListPlaceholer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Expanded(
            child: Text('Пусто'),
          ),
        ],
      ),
    );
  }
}
