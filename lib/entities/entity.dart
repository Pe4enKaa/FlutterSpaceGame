
import 'package:flutter/cupertino.dart';

abstract class Entity {
  late double x;
  late double y;
  String spriteName;
  bool visible = true;
  List sprites = [];

  Entity(this.spriteName) {
    for (var i = 0; i < 4; i++) {
      sprites.add(Image.asset("assests/$spriteName$i.png"));
    }
  }
  void update();
  void move();

  Widget build();
}