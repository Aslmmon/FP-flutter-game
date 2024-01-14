import 'package:fb_game/components/background/background.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'components/player.dart';
import 'components/sprite/sprite_player.dart';

class FBgameApp extends FlameGame with HasCollisionDetection {
  FBgameApp();

  late Player _player;
  double objectSpeed = 0.0;

  @override
  Future<void> onLoad() async {
    add(Background());
    add(SpriteComp(
        position: Vector2(200, 400), size: Vector2(128.0, 128.0), speed: 120.0));
    add(ScreenHitbox());
    camera.viewfinder.anchor = Anchor.center;
    //
    // initializeGame();

    debugMode = true;
  }
}
