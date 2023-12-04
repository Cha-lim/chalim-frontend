import 'package:flutter/material.dart';

class CameraShotButton extends StatelessWidget {
  const CameraShotButton({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.2,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0), // 내부 원의 색상
        shape: BoxShape.circle, // 원형 모양
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, // 외부 원의 색상
              shape: BoxShape.circle, // 원형 모양
            ),
          ),
        ),
      ),
    );
  }
}
