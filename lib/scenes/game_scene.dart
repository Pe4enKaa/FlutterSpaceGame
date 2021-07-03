import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:game_mamed/entities/player.dart';
import 'package:game_mamed/scenes/app_scene.dart';
import 'package:game_mamed/utils/global_vars.dart';

class GameScene extends AppScene {

   Player _player = Player();
   double _startGlobalPosition = 0;
  @override
  Widget buildScene() {
    return Stack(
      children: [
        _player.build(),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.green)),
            width: GlobalVars.screenWidth/2,
            height: GlobalVars.screenHeight,
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
              ),
            ))
      ],
    );
  }

  @override
  void update() {
    _player.update();
  }

  GameScene();

  void _onPanStart(DragStartDetails details) {
      _startGlobalPosition = details.globalPosition.dx;

  }

  void _onPanUpdate(DragUpdateDetails details) {
      double _updateGlobalPosition = details.globalPosition.dx;
      if (_updateGlobalPosition> _startGlobalPosition + 20) {
          _player.isMoveRight = true;
      }
      if (_updateGlobalPosition< _startGlobalPosition - 20) {
          _player.isMoveLeft = true;
      }
  }
}

