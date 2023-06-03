import 'package:flutter/material.dart';
import 'dart:math';

  double Object_width = 60;
  double Object_height = 60;

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'Horizon',
);

enum ObjectType {
  Rock,
  Paper,
  Scissors,
}

class GameObject {
  final ObjectType type;
  double x;
  double y;
  double dx;
  double dy;

  GameObject({
    required this.type,
    required this.x,
    required this.y,
    required this.dx,
    required this.dy,
  });
}
void createObjects({required List<GameObject> objects,required Random random, required ObjectType mytype}) {
  for (int i = 0; i < 5; i++) {
    objects.add(
        GameObject(
      type: mytype,
      x: random.nextDouble() * 400,
      y: random.nextDouble() * 400,
      dx: (random.nextDouble() - 0.5) * 2,
      dy: (random.nextDouble() - 0.5) * 2,
    ));
  }

}
