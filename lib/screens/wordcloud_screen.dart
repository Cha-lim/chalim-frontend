import 'package:chalim/constants/gaps.dart';
import 'package:chalim/constants/sizes.dart';
import 'package:chalim/services/word_cloud.dart';
import 'package:chalim/widgets/loading_bar.dart';
import 'package:chalim/widgets/select_language_button.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WordcloudScreen extends StatelessWidget {
  const WordcloudScreen({
    super.key,
    required this.restaurantName,
    required this.menuNames,
  });

  final String restaurantName;
  final List<dynamic> menuNames;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SelectLanguageButton(),
        actions: const [
          FaIcon(
            FontAwesomeIcons.ellipsis,
            size: Sizes.size28,
          ),
          Gaps.h10,
        ],
      ),
      body: FutureBuilder(
        future: WordCloud.getWordCloud(
          restaurantName: restaurantName,
          menuNames: menuNames,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Text(' $restaurantName의 차림상 추천',
                    style: Theme.of(context).textTheme.displayLarge),
                Image.file(
                  snapshot.data,
                ),
              ],
            );
          } else {
            return const Center(
              child: LoadingBar(
                message: '차림상 추천을 준비 중입니다.',
              ),
            );
          }
        },
      ),
    );
  }
}
