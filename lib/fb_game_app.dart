import 'package:fb_game/components/background/background.dart';
import 'package:fb_game/components/sprite/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
import 'components/hud/hud.dart';
import 'components/hud/run_button.dart';
import 'components/sprite/sprite_player.dart';

class FBgameApp extends FlameGame with HasCollisionDetection,DragCallbacks,TapCallbacks{
  FBgameApp();

  double objectSpeed = 0.0;

  late final JoystickComponent joystick;
  late RunButton runButton;
  final buttonRunPaint = BasicPalette.red.withAlpha(200).paint();
  final buttonDownRunPaint = BasicPalette.red.withAlpha(100).paint();
  @override
  Future<void> onLoad() async {
    add(Background());
    add(SpriteComp(position: Vector2(200, 400), size: Vector2(128.0, 128.0), speed: 120.0));
    add(Enemy(position: Vector2(50, 50), size: Vector2(128.0, 128.0), speed: 50.0));
     add(HudComponent());
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    runButton = RunButton(
        button: CircleComponent(radius: 25.0, paint: buttonRunPaint),
        buttonDown: CircleComponent(radius: 25.0, paint: buttonDownRunPaint),
        margin: const EdgeInsets.only(right: 20, bottom: 50),
        onPressed: () => {});

    camera.viewport.add(joystick);
    camera.viewport.add(runButton);

    add(ScreenHitbox());
    camera.viewfinder.anchor = Anchor.center;
    debugMode = true;
  }
}
