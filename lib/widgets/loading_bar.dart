import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:chalim/constants/sizes.dart';
import 'package:chalim/constants/gaps.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingAnimationWidget.dotsTriangle(
            color: Colors.white,
            size: Sizes.size32,
          ),
          Gaps.v10,
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size20,
            ),
          ),
        ],
      ),
    );
  }
}
