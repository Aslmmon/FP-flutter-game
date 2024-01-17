import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

import '../sprite/sprite_player.dart';

class Background extends PositionComponent with TapCallbacks {
  static final backgroundPaint =
  BasicPalette.white.paint();
  late double screenWidth, screenHeight;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(0, 0);
    size = Vector2(size.x, size.y);
  }
  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   canvas.drawRect(Rect.fromPoints(position.toOffset(),
  //       size.toOffset()), backgroundPaint);
  // }


  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
  }

}