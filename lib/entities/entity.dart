
import 'package:flutter/cupertino.dart';

abstract class Entity {
  late double x;
  late double y;
  String spriteName;
  bool visible = true;
  List sprites = [];
  int currentSprite = 0;
  int currentTick = 0;

  Entity(this.spriteName) {
    for (var i = 0; i < 4; i++) {
      sprites.add(Image.asset("assests/$spriteName$i.png"));
    }
  }
  void update() {
    _animate();
    move();
  }
  void move();
  void _animate() {
      currentTick++;
      if (currentTick>7) {
        currentSprite++;
        currentTick = 0;
      }
      if (currentSprite>3) {
          currentSprite = 0;
      }
  }
  Widget build();
}