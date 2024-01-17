import 'package:fb_game/fb_game_app.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  runApp(
    const GameWidget<FBgameApp>.controlled(
      gameFactory: FBgameApp.new,),
  );




}
