import 'package:fb_game/components/background/background.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/background/ground_block.dart';
import 'components/background/platform_block.dart';
import 'components/background/star.dart';
import 'components/enemy.dart';
import 'components/player.dart';
import 'components/sprite/sprite_player.dart';
import 'managers/background_manager.dart';
import 'package:flame/sprite.dart';

class FBgameApp extends FlameGame {
  FBgameApp();
  late Player _player;
  double objectSpeed = 0.0;


  SpriteAnimationComponent animationComponent1 =
  SpriteAnimationComponent(size: Vector2(840, 440));

  @override
  Future<void> onLoad() async {
    // await images.loadAll([
    //   'block.png',
    //   'ember.png',
    //   'ground.png',
    //   'heart_half.png',
    //   'heart.png',
    //   'star.png',
    //   'water_enemy.png',
    //   'Run.png',
    //
    // ]);


    add(Background());
    add( SpriteComp());

    // camera.viewfinder.anchor = Anchor.topLeft;
    //
    // initializeGame();

    debugMode = true;

  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          break;
        case PlatformBlock:
          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case Star:
          break;
        case WaterEnemy:
          break;
      }
    }
  }

  void initializeGame() {
    // Assume that size.x < 3200
    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    _player = Player(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_player);
  }

  Future<void> loadAnimations() async {
    SpriteSheet spriteSheet =
    SpriteSheet(image: await images.load('Run.png'),  srcSize: Vector2(1226, 1226));
    SpriteAnimation spriteAnimation =
    spriteSheet.createAnimation(row: 0, stepTime: 0.7, from: 5, to: 24);

    animationComponent1.animation = spriteAnimation;
  }
}