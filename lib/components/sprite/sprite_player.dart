import 'dart:async';

import 'package:fb_game/components/sprite/enemy.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import '../hud/hud.dart';
import '../hud/run_button.dart';
import 'Character.dart';

class SpriteComp extends Character {
  SpriteComp(this.joystickComponent, this.runButton, this.hudComponent,
      {required Vector2 position, required Vector2 size, required double speed})
      : super(position: position, size: size, speed: speed);

  late double walkingSpeed, runningSpeed;
  final JoystickComponent joystickComponent;
  final RunButton runButton;
  final HudComponent hudComponent;

  @override
  Future<void> onLoad() async {
    walkingSpeed = speed;
    runningSpeed = speed * 2;

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
    animation = downAnimation;
    playing = false;
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is Enemy) {
      animation = deadAnimation;
      removeFromParent();
      hudComponent.scoreText.setScore(10);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    speed = runButton.buttonPressed ?
    runningSpeed : walkingSpeed;

    if (!joystickComponent.delta.isZero()) {
      position.add(joystickComponent.relativeDelta * speed * dt);
      playing = true;
      switch (joystickComponent.direction) {
        case JoystickDirection.up:
        case JoystickDirection.upRight:
        case JoystickDirection.upLeft:
          animation = upAnimation;
          currentDirection = Character.up;
          break;
        case JoystickDirection.down:
        case JoystickDirection.downRight:
        case JoystickDirection.downLeft:
          animation = downAnimation;
          currentDirection = Character.down;
          break;
        case JoystickDirection.left:
          animation = leftAnimation;
          currentDirection = Character.left;
          break;
        case JoystickDirection.right:
          animation = rightAnimation;
          currentDirection = Character.right;
          break;
        case JoystickDirection.idle:
          animation = null;
          break;
      }
    } else {
      if (playing) {
        stopAnimations();
      }
    }
  }
  void stopAnimations() {
   // animation?.currentIndex = 0;
    playing = false;
  }

}
