import 'package:fb_game/fb_game_app.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';

class RunButton extends HudButtonComponent with TapCallbacks {
  RunButton({
    required button,
    buttonDown,
    EdgeInsets? margin,
    Vector2? position,
    Vector2? size,
    Anchor anchor = Anchor.center,
    onPressed,
  }) : super(
      button: button,
      buttonDown: buttonDown,
      margin: margin,
      position: position,
      size: size ?? button.size,
      anchor: anchor,
      onPressed: onPressed
  );
  bool buttonPressed = false;

  @override
  void onTapUp(TapUpEvent event) {
    buttonPressed = true;
  }
  @override
  void onTapCancel(TapCancelEvent event) {
    buttonPressed = false;
    super.onTapCancel(event);
  }
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    buttonPressed = true;
  }

}