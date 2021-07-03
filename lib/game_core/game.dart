import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:game_mamed/utils/global_vars.dart';
import 'main_loop.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState()=> _GameState();
}
class _GameState extends State<Game> {

  late ReceivePort _receivePort;
  late Isolate _isolateLoop;

  void _startIsolateLoop() async{
    _receivePort = ReceivePort();
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);
    _receivePort.listen((message) {
      GlobalVars.currentScene.update();
      setState(() {
      });
    });
  }
  @override
  void dispose() {
    _receivePort.close();
    _isolateLoop.kill();
    super.dispose();
  }
  @override
  void initState() {
    _startIsolateLoop();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return GlobalVars.currentScene.buildScene();
  }
}