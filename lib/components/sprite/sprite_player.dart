import 'dart:async';
import 'package:fb_game/components/sprite/enemy.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import '../coin/Coin.dart';
import '../hud/hud.dart';
import '../hud/run_button.dart';
import 'Character.dart';

class SpriteComp extends Character {
  SpriteComp( this.hudComponent,
      {required Vector2 position, required Vector2 size, required double speed})
      : super(position: position, size: size, speed: speed);

  late double walkingSpeed, runningSpeed;
  final HudComponent hudComponent;

  late bool isFlipped;
  bool isMoving = false;
  late AudioPlayer audioPlayerRunning;


  @override
  Future<void> onLoad() async {
    isFlipped = false;
    walkingSpeed = speed;
    runningSpeed = speed * 2;
    scale = Vector2(2.5, 2.5);
    var spriteImages = await Flame.images.load('Old_woman_walk.png');
    var attachSprite = await Flame.images.load('Old_woman_attack.png');

    final spriteSheet =
        SpriteSheet(image: spriteImages, srcSize: Vector2(width, height));
    final attackSpriteSheet =
        SpriteSheet(image: attachSprite, srcSize: Vector2(width, height));

    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.5);
    downAnimation =
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.5);
    leftAnimation =
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.5);
    upAnimation =
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2);
    rightAnimation =
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2);
    attackAnimation = attackSpriteSheet.createAnimation(row: 0, stepTime: 0.2);
    animation = downAnimation;
    playing = false;
    add(RectangleHitbox());


    await FlameAudio.audioCache.loadAll(
        ['enemy_dies.wav', 'running.wav', 'coin.wav']);
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    debugPrint("collision is on $other");
    if (other is Enemy) {
      other.removeFromParent();
      animation = attackAnimation;
      hudComponent.scoreText.setScore(10);
      FlameAudio.play('enemy_dies.wav',volume: 1.0);
    }
    if (other is Coin) {
      other.removeFromParent();
      hudComponent.scoreText.setScore(20);
      FlameAudio.play('coin.wav', volume: 1.0);
    }
  }

  @override
  void onPaused() {
    if (isMoving) {
      audioPlayerRunning.pause();
    }
  }
  @override
  void onResumed() {
    if (isMoving) {
      audioPlayerRunning.resume();
    }
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    speed = hudComponent.runButton.buttonPressed ? runningSpeed : walkingSpeed;

    if (!hudComponent.joystick.delta.isZero()) {
      position.add(hudComponent.joystick.relativeDelta * speed * dt);
      playing = true;
      if (!isMoving) {
        isMoving = true;
        audioPlayerRunning = await FlameAudio.loopLongAudio('running.wav', volume: 1.0);
      }
      switch (hudComponent.joystick.direction) {
        case JoystickDirection.up:
        case JoystickDirection.upRight:
        if (isFlipped) {
          flipHorizontally();
          isFlipped = false;
        }
        animation = upAnimation;
        currentDirection = Character.up;
        break;
        case JoystickDirection.upLeft:
        if (!isFlipped) {
          flipHorizontally();
          isFlipped = true;
        }
          animation = upAnimation;
          currentDirection = Character.up;
          break;
        case JoystickDirection.down:
        case JoystickDirection.downRight:
        if (isFlipped) {
          flipHorizontally();
          isFlipped = false;
        }
        animation = downAnimation;
        currentDirection = Character.down;
        case JoystickDirection.downLeft:
        if (!isFlipped) {
          flipHorizontally();
          isFlipped = true;
        }
          animation = downAnimation;
          currentDirection = Character.down;
          break;
        case JoystickDirection.left:
          if (!isFlipped) {
            flipHorizontally();
            isFlipped = true;
          }
          animation = leftAnimation;
          isFlipped = true;
          currentDirection = Character.left;
          break;
        case JoystickDirection.right:
          if (isFlipped) {
            flipHorizontally();
            isFlipped = false;
          }
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
      if (isMoving) {
        debugPrint("i'm here");
        isMoving = false;
        audioPlayerRunning.stop();
      }

    }
  }

  void stopAnimations() {
    // animation?.currentIndex = 0;
    playing = false;
  }

}
