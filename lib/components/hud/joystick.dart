import 'package:fb_game/fb_game_app.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class Joystick extends JoystickComponent with HasGameRef<FBgameApp> {
  Joystick({required PositionComponent knob,
    PositionComponent? background, EdgeInsets?
    margin}) : super (knob: knob, background:
  background, margin: margin);


}
