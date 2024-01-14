import 'dart:async';

import 'package:fb_game/components/sprite/enemy.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'Character.dart';

class SpriteComp extends Character {
  SpriteComp(
      {required Vector2 position, required Vector2 size, required double speed})
      : super(position: position, size: size, speed: speed);

  @override
  Future<void> onLoad() async {
    var spriteImages = await Flame.images.load('Walk.png');
    final spriteSheet =
        SpriteSheet(image: spriteImages, srcSize: Vector2(width, height));
    final spriteSheetOfRuning = SpriteSheet(
        image: await Flame.images.load("Run.png"),
        srcSize: Vector2(width, height));

    final spriteSheetDead = SpriteSheet(
        image: await Flame.images.load("Dead.png"),
        srcSize: Vector2(width, height));
    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.5);
    downAnimation =
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.5);
    leftAnimation =
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.5);
    upAnimation =
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2);
    rightAnimation =
        animation = spriteSheetOfRuning.createAnimation(row: 0, stepTime: 0.2);
    deadAnimation =
        animation = spriteSheetDead.createAnimation(row: 0, stepTime: 0.2);
    changeDirection();
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is Enemy) {
      animation = deadAnimation;
      removeFromParent();
    }
  }
}
