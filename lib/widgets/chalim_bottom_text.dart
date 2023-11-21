// flutter
import 'package:flutter/material.dart';

// constants
import 'package:chalim/constants/sizes.dart';

class ChalimBottomText extends StatelessWidget {
  const ChalimBottomText({
    super.key,
    required this.textColor,
  });

  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      'CHALIM',
      style: TextStyle(
        color: textColor,
        fontSize: Sizes.size28,
        fontFamily: 'Myriad Pro',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
