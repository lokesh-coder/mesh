import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

int getRandom(int min, int max) {
  Random rnd = Random();
  return min + rnd.nextInt(max - min);
}

class Mesh extends StatelessWidget {
  const Mesh({Key? key}) : super(key: key);

  getMeshItem(BoxConstraints c) {
    final Color startColor = RandomColor().randomColor();
    return Container(
      width: getRandom(200, c.maxWidth.toInt()).toDouble(),
      height: getRandom(100, c.maxHeight.toInt()).toDouble(),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          focal: Alignment.center,
          radius: 2,
          colors: [startColor, Colors.transparent],
        ),
      ),
    );
  }

  List<Widget> getColorItem(BoxConstraints c) {
    return [
      Positioned(
        child: getMeshItem(c),
        left: getRandom(-200, c.maxWidth.toInt() + 100).toDouble(),
        top: getRandom(-200, c.maxHeight.toInt() + 100).toDouble(),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(
          color: Colors.black.withOpacity(0),
        ),
      )
    ];
  }

  List<Widget> getColors(count, c) {
    return List.generate(count, (index) {
      return getColorItem(c);
    }).expand((e) => e).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RandomColor().randomColor(),
      width: double.infinity,
      height: double.infinity,
      child: LayoutBuilder(builder: (_, c) {
        return Stack(children: getColors(7, c));
      }),
    );
  }
}
