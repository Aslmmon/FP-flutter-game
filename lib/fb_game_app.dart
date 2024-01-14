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

class FBgameApp extends FlameGame with HasCollisionDetection {
  FBgameApp();
  late Player _player;
  double objectSpeed = 0.0;
  @override
  Future<void> onLoad() async {

    add(Background());
    add( SpriteComp());
     add(ScreenHitbox());
     camera.viewfinder.anchor = Anchor.center;
    //
    // initializeGame();

    debugMode = true;

  }

}