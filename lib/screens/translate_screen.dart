// flutter
import 'package:chalim/services/get_exchange_rate.dart';
import 'package:country_flags/country_flags.dart';
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
  late final num _imageWidth;
  late final num _imageHeight;

  late Future<dynamic> _translateFuture;

  num _exchangedPrice = 0;

  @override
  void initState() {
    super.initState();
    _getImageSize();
    _translateFuture = TranslateImage.translateImage(
      widget.image,
      ref.read(languageSelectProvider).name.toLowerCase(),
    );
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

  void _onTapPriceBox(dynamic priceValue) async {
    print('priceValue: $priceValue');

    print(ref.read(languageSelectProvider).name);

    num exchangedPrice = 0;
    if (ref.read(languageSelectProvider).name == 'english') {
      exchangedPrice = await ExchangeRate.getExchangeRate(
        to: 'usd',
        amount: priceValue.toString(),
      );
    } else if (ref.read(languageSelectProvider).name == 'japanese') {
      exchangedPrice = await ExchangeRate.getExchangeRate(
        to: 'jpy',
        amount: priceValue.toString(),
      );
    } else if (ref.read(languageSelectProvider).name == 'chinese') {
      exchangedPrice = await ExchangeRate.getExchangeRate(
        to: 'cny',
        amount: priceValue.toString(),
      );
    }
    setState(() {
      _exchangedPrice = exchangedPrice;
    });
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
        future: _translateFuture,
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

          final menuBoxes = boxes['menu'] as List<dynamic>;
          final priceBoxes = boxes['price'] as List<dynamic>;

          final deviceWidth = MediaQuery.of(context).size.width;
          final deviceHeight = MediaQuery.of(context).size.height;
          final appBarHeight = Scaffold.of(context).appBarMaxHeight;

          final double scaleFactorWidth = deviceWidth / _imageWidth;
          final double scaleFactorHeight =
              (deviceHeight - appBarHeight!) / _imageHeight;
          // print(boxes[0].points[0][0]);
          return Stack(
            children: [
              Positioned.fill(
                child: Image.file(
                  File(widget.image.path),
                  width: deviceWidth,
                  height: deviceHeight - appBarHeight,
                  fit: BoxFit.fill,
                ),
              ),
              ...menuBoxes.map((menuBox) {
                final double left = menuBox['points'][0][0] * scaleFactorWidth;
                final double top = menuBox['points'][0][1] * scaleFactorHeight;
                final double boxWidth =
                    (menuBox['points'][1][0] - menuBox['points'][0][0]) *
                        scaleFactorWidth;
                final double boxHeight =
                    (menuBox['points'][2][1] - menuBox['points'][0][1]) *
                        scaleFactorHeight;

                return Positioned(
                  left: left,
                  top: top,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: boxWidth,
                      height: boxHeight,
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
                  ),
                );
              }).toList(),
              ...priceBoxes.map((priceBox) {
                final double left = priceBox['points'][0][0] * scaleFactorWidth;
                final double top = priceBox['points'][0][1] * scaleFactorHeight;
                final double boxWidth =
                    (priceBox['points'][1][0] - priceBox['points'][0][0]) *
                        scaleFactorWidth;
                final double boxHeight =
                    (priceBox['points'][2][1] - priceBox['points'][0][1]) *
                        scaleFactorHeight;

                return Positioned(
                  left: left,
                  top: top,
                  child: GestureDetector(
                    onTap: () {
                      _onTapPriceBox(priceBox['priceValue']);
                    },
                    child: Column(
                      children: [
                        Container(
                          width: boxWidth,
                          height: boxHeight,
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
                        if (_exchangedPrice != 0)
                          Container(
                            width: boxWidth,
                            height: boxHeight,
                            color: Colors.white.withOpacity(0.5),
                            child: Expanded(
                              child: Row(
                                children: [
                                  CountryFlag.fromCountryCode(
                                    selectedLanguage.name == 'english'
                                        ? 'US'
                                        : selectedLanguage.name == 'japanese'
                                            ? 'JP'
                                            : 'CN',
                                    width: Sizes.size20,
                                    height: Sizes.size20,
                                  ),
                                  Text(
                                    '(\$${_exchangedPrice.toStringAsFixed(2)})',
                                    style: const TextStyle(
                                      fontSize: Sizes.size20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
