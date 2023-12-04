import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class PhotoSelectScreen extends StatefulWidget {
  const PhotoSelectScreen({super.key});

  @override
  State<PhotoSelectScreen> createState() => _PhotoSelectScreenState();
}

class _PhotoSelectScreenState extends State<PhotoSelectScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
