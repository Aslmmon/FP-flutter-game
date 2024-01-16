import 'package:fb_game/fb_game_app.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const GameWidget<FBgameApp>.controlled(
      gameFactory: FBgameApp.new,),
  );




}
