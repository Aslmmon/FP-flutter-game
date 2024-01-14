import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'Character.dart';

class Enemy extends Character {
  Enemy(
      {required Vector2 position, required Vector2 size, required double speed})
      : super(position: position, size: size, speed: speed);

  @override
  Future<void> onLoad() async {
    final spriteSheetOfWalkingSoldiers = SpriteSheet(
        image: await Flame.images.load("Walk_solider.png"),
        srcSize: Vector2(width, height));
    animation =
        spriteSheetOfWalkingSoldiers.createAnimation(row: 0, stepTime: 0.1);
    downAnimation = animation =
        spriteSheetOfWalkingSoldiers.createAnimation(row: 0, stepTime: 0.1);
    leftAnimation = animation =
        spriteSheetOfWalkingSoldiers.createAnimation(row: 0, stepTime: 0.1);
    upAnimation = animation =
        spriteSheetOfWalkingSoldiers.createAnimation(row: 0, stepTime: 0.1);
    rightAnimation = animation =
        spriteSheetOfWalkingSoldiers.createAnimation(row: 0, stepTime: 0.1);

    changeDirection();
    add(RectangleHitbox());
    return super.onLoad();
  }
}
