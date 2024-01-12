import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'components/player.dart';

class FBgameApp extends FlameGame {
  FBgameApp();
  late Player _player;


  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'Protect.png',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;

    _player = Player(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_player);

  }
}