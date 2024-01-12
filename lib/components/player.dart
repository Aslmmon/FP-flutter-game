import 'package:fb_game/fb_game_app.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<FBgameApp> {
  Player({
    required super.position,
  }) : super(size: Vector2.all(150), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Protect.png'),
      SpriteAnimationData.sequenced(
        amount: 8,
        textureSize: Vector2.all(64),
        stepTime: 0.12,
      ),
    );
  }
}