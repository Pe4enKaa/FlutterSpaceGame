import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:game_mamed/entities/bullet.dart';
import 'package:game_mamed/entities/player.dart';
import 'package:game_mamed/scenes/app_scene.dart';
import 'package:game_mamed/utils/global_vars.dart';

class GameScene extends AppScene {

   Player _player = Player();
   double _startGlobalPosition = 0;
   List<Bullet> _listBullets = [];
   List<Widget> _listWidgets = [];
  @override
  Widget buildScene() {
    return Stack(
      children: [
        _player.build(),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
          decoration:  BoxDecoration(border: Border.all(color: Colors.green)),
          width: GlobalVars.screenWidth/2,
          height: GlobalVars.screenHeight,
          child: GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
          ),
        )),
        Positioned(
            top: 0,
            left: GlobalVars.screenWidth /2,
            child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.green)),
            width: GlobalVars.screenWidth/2,
            height: GlobalVars.screenHeight/2,
              child: GestureDetector(
               onTap: _onAcceleration,
              ),
            )),
        Positioned(
            top: GlobalVars.screenHeight /2,
            left: GlobalVars.screenWidth /2,
            child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.green)),
            width: GlobalVars.screenWidth/2,
            height: GlobalVars.screenHeight/2,
              child: GestureDetector(
               onTap: _onShoot,
              ),
            )),
        Stack(
          children: _listWidgets,
        )
      ],
    );
  }

  @override
  void update() {
    _player.update();
    _listBullets.removeWhere((element) => !element.visible);
    _listBullets.forEach((element) {
      _listWidgets.add(element.build());
      element.update();
    });
  }

  GameScene();

  void _onPanStart(DragStartDetails details) {
      _startGlobalPosition = details.globalPosition.dx;

  }

  void _onPanUpdate(DragUpdateDetails details) {
      double _updateGlobalPosition = details.globalPosition.dx;
      if (_updateGlobalPosition> _startGlobalPosition + 30) {
          _player.isMoveRight = true;
      }
      if (_updateGlobalPosition< _startGlobalPosition - 30) {
          _player.isMoveLeft = true;
      }
  }

  void _onAcceleration() {
        _player.isAcceleration = _player.isAcceleration?false:true;
  }

  void _onShoot() {
      _listBullets.add(Bullet(playerAngle: _player.getAngle, playerX: _player.x, playerY: _player.y));
  }
}

