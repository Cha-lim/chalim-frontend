// flutter
import 'package:chalim/services/get_exchange_rate.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// libraries
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

// screens
import 'package:chalim/screens/map_screen.dart';

// widgets
import 'package:chalim/widgets/select_language_button.dart';
import 'package:chalim/widgets/loading_bar.dart';

// constants
import 'package:chalim/constants/sizes.dart';
import 'package:chalim/constants/gaps.dart';

// services
import 'package:chalim/services/translate_image.dart';

// providers
import 'package:chalim/providers/language_provider.dart';

class TranslateScreen extends ConsumerStatefulWidget {
  const TranslateScreen({
    super.key,
    required this.image,
  });

  final XFile image;

  @override
  ConsumerState<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends ConsumerState<TranslateScreen> {
  late final int _imageWidth;
  late final int _imageHeight;

  @override
  void initState() {
    super.initState();
    _getImageSize();
  }

  void _getImageSize() async {
    final File imageFile = File(widget.image.path); // Convert XFile to File
    final img.Image? image = img.decodeImage(await imageFile.readAsBytes());

    if (image != null) {
      setState(() {
        _imageWidth = image.width;
        _imageHeight = image.height;
      });
    }
  }

  void _navigateToWordcloudScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );
  }

  void _onTapPriceBox() async {
    final exchangeRate = await ExchangeRate.getExchangeRate();
    print(exchangeRate);
  }

  @override
  Widget build(BuildContext context) {
    Language selectedLanguage = ref.watch(languageSelectProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SelectLanguageButton(),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToWordcloudScreen(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.solidStar,
              size: Sizes.size28,
            ),
          ),
          Gaps.h10,
          const FaIcon(
            FontAwesomeIcons.ellipsis,
            size: Sizes.size28,
          ),
          Gaps.h10,
        ],
        elevation: 5,
      ),
      body: FutureBuilder(
        future: TranslateImage.translateImage(
          widget.image,
          selectedLanguage.name.toLowerCase(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBar(
              message: '차림상을 준비 중입니다.',
            );
          }
          if (!snapshot.hasData || snapshot.hasError) {
            return const Text('오류가 발생했습니다.');
          }

          if (snapshot.data['menu'] == null || snapshot.data['price'] == null) {
            return const Text('메뉴와 가격을 인식하지 못했습니다.');
          }

          final boxes = snapshot.data;

          print('boxes: $boxes');

          final menuBoxes = boxes['menu'] as List<dynamic>;
          final priceBoxes = boxes['price'] as List<dynamic>;

          final deviceWidth = MediaQuery.of(context).size.width;
          final deviceHeight = MediaQuery.of(context).size.height;
          final appBarHeight = Scaffold.of(context).appBarMaxHeight;

          // print(boxes[0].points[0][0]);
          return Stack(
            children: [
              Positioned.fill(
                child: Image.file(
                  File(widget.image.path),
                  width: deviceWidth,
                  height: deviceHeight - appBarHeight!,
                  fit: BoxFit.fill,
                ),
              ),
              ...menuBoxes.map((menuBox) {
                return Positioned(
                  left:
                      menuBox['points'][3][0].toDouble() * (deviceWidth / 3024),
                  top: menuBox['points'][3][1].toDouble() *
                          ((deviceHeight - appBarHeight) / 4032) -
                      20,
                  child: Container(
                    width: (menuBox['points'][1][0].toDouble() -
                            menuBox['points'][0][0].toDouble()) *
                        (deviceWidth / 3024),
                    height: (menuBox['points'][2][1].toDouble() -
                            menuBox['points'][1][1].toDouble()) *
                        ((deviceHeight - appBarHeight) / 4032),
                    color: Colors.white.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        menuBox['transcription'],
                        style: const TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              ...priceBoxes.map((priceBox) {
                return Positioned(
                  left: priceBox['points'][3][0].toDouble() *
                      (deviceWidth / 3024),
                  top: priceBox['points'][3][1].toDouble() *
                          ((deviceHeight - appBarHeight) / _imageWidth) -
                      20,
                  child: GestureDetector(
                    onTap: _onTapPriceBox,
                    child: Container(
                      width: (priceBox['points'][1][0].toDouble() -
                              priceBox['points'][0][0].toDouble()) *
                          (deviceWidth / 3024),
                      height: (priceBox['points'][2][1].toDouble() -
                              priceBox['points'][1][1].toDouble()) *
                          ((deviceHeight - appBarHeight) / _imageHeight),
                      color: Colors.white.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          priceBox['priceValue'] + '원',
                          style: const TextStyle(
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          );
        },
      ),
    );
  }
}
