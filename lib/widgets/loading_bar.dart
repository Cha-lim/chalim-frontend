import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:chalim/constants/sizes.dart';
import 'package:chalim/constants/gaps.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    super.key,
    required this.message,
    this.isTextWhite = false,
  });

  final String message;
  final bool isTextWhite;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingAnimationWidget.dotsTriangle(
            color: isTextWhite ? Colors.white : Theme.of(context).primaryColor,
            size: Sizes.size32,
          ),
          Gaps.v10,
          Text(
            message,
            style: TextStyle(
              color:
                  isTextWhite ? Colors.white : Theme.of(context).primaryColor,
              fontSize: Sizes.size20,
            ),
          ),
        ],
      ),
    );
  }
}
