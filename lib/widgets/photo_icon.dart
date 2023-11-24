import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhotoIcon extends StatelessWidget {
  const PhotoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FaIcon(
        FontAwesomeIcons.solidImage,
        size: 50,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
