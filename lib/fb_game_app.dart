import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/background/ground_block.dart';
import 'components/background/platform_block.dart';
import 'components/background/star.dart';
import 'components/enemy.dart';
import 'components/player.dart';
import 'managers/background_manager.dart';

class FBgameApp extends FlameGame {
  FBgameApp();
  late Player _player;
  double objectSpeed = 0.0;


  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'Run.png',

    ]);


    camera.viewfinder.anchor = Anchor.topLeft;

    initializeGame();

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
}