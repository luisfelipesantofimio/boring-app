import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() {
  final random = Random();

  List<Color> color = [
    const Color.fromARGB(255, 240, 156, 255),
    const Color.fromARGB(255, 255, 245, 158),
    const Color.fromARGB(255, 173, 218, 255),
    Colors.white,
    const Color.fromARGB(255, 177, 255, 180),
    const Color.fromARGB(255, 255, 175, 202),
    const Color.fromARGB(255, 255, 171, 165),
  ];

  Color element = color[random.nextInt(color.length)];
  return element;
}

Color challengeColor(double value) {
  if (value < 0.3) {
    return Colors.green;
  } else if (value > 0.3 && value < 0.5) {
    return const Color.fromARGB(255, 155, 201, 157);
  } else if (value > 0.5 && value < 0.6) {
    return Colors.amber;
  } else if (value > 0.6 && value < 0.9) {
    return const Color.fromARGB(255, 215, 114, 114);
  } else {
    return Colors.red;
  }
}
