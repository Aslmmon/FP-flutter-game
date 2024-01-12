import 'package:fb_game/fb_game_app.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<FBgameApp> {
  Player({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }
}