import 'package:flutter/material.dart';

import '../utils/styles.dart';

class TitleSection extends StatelessWidget {
  final String text;
  final TextStyle style;

  const TitleSection({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: style),
        Icon(Icons.more_horiz, color: icon, size: 28),
      ],
    );
  }
}
