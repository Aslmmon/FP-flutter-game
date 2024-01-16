import 'dart:math';

import 'package:fb_game/components/background/background.dart';
import 'package:fb_game/components/sprite/enemy.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/experimental.dart'; // Gives you the Rectangle
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/cupertino.dart';
import 'components/coin/Coin.dart';
import 'components/hud/hud.dart';
import 'components/hud/run_button.dart';
import 'components/sprite/Character.dart';
import 'components/sprite/sprite_player.dart';

class FBgameApp extends FlameGame
    with HasCollisionDetection, DragCallbacks, TapCallbacks {
  FBgameApp();

  double objectSpeed = 0.0;

  late final JoystickComponent joystick;
  late final HudComponent hudComponent;

  late RunButton runButton;
  late SpriteComp spriteComponent;

  final buttonRunPaint = BasicPalette.red.withAlpha(200).paint();
  final buttonDownRunPaint = BasicPalette.red.withAlpha(100).paint();
  final world = World();
  late final CameraComponent cameraComponent;



  @override
  Future<void> onLoad() async {
    camera.setBounds(Rectangle.fromRect(const Rect.fromLTRB(0, 0, 1600, 1600)));
    var background = Background();
    //add(world)

    add(Background());
    final tiledMap = await TiledComponent.load('tiles.tmx', Vector2.all(32));
    add(tiledMap);
    Random random = Random(DateTime
        .now()
        .millisecondsSinceEpoch);
    for (int i = 0; i < 50; i++) {
      int randomX = random.nextInt(48) + 1;
      int randomY = random.nextInt(48) + 1;
      double posCoinX = (randomX * 32) + 5;
      double posCoinY = (randomY * 32) + 5;
      add(Coin(position: Vector2(posCoinX, posCoinY),
          size: Vector2(20, 20)));
    }
    final enemies = tiledMap.tileMap.getLayer<ObjectGroup>('Enemies');
    enemies?.objects.asMap().forEach((index, position) {
      if (index % 2 == 0) {
        add(Enemy(position: Vector2(position.x, position.y),
            size: Vector2(128.0, 128.0),
            speed: 50.0));
      } else {
        add(Enemy(position: Vector2(position.x, position.y),
            size: Vector2(128.0, 128.0),
            speed: 50.0));
      }
    });


    hudComponent = HudComponent();
    add(hudComponent);
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
        onPressed: () =>
        {
          //    FlameAudio.play('music.mp3')
          debugPrint("called")
        });

    spriteComponent = SpriteComp(joystick, runButton, hudComponent,camera,
        position: Vector2(200, 400),
        size: Vector2(48, 48),
        speed: 120.0);
    camera.follow(spriteComponent);

    add(spriteComponent);
   add(joystick);
   add(runButton);

    add(ScreenHitbox());

    FlameAudio.bgm.initialize();
    //FlameAudio.play('music.mp3')

    debugMode = true;
    }

  @override
  void onRemove() {
    FlameAudio.bgm.stop();
    FlameAudio.audioCache.clearAll();
    super.onRemove();
  }




  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        children.forEach((component) {
          if (component is Character) {
            component.onPaused();
          }
        });
        break;
      case AppLifecycleState.resumed:
        children.forEach((component) {
          if (component is Character) {
            component.onResumed();
          }
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
        break;
    }
  }

}
