import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';

class SpriteComp extends SpriteAnimationComponent {
  late double screenWidth, screenHeight, centerX, centerY;
  late double georgeSizeWidth = 128.0, georgeSizeHeight = 128.0;

  late SpriteAnimation georgeDownAnimation,
      georgeLeftAnimation,
      georgeUpAnimation,
      georgeRightAnimation;
  double elapsedTime = 0.0;
  double georgeSpeed = 40.0;
  int currentDirection = down;
  static const int down = 0, left = 1, up = 2, right = 3;

  @override
  Future<void> onLoad() async {
    screenWidth = MediaQueryData.fromView(window).size.width;
    screenHeight = MediaQueryData.fromView(window).size.height;
    centerX = (screenWidth / 2) - (georgeSizeWidth / 2);
    centerY = (screenHeight / 2) - (georgeSizeHeight / 2);

    var spriteImages = await Flame.images.load('Walk.png');
    final spriteSheet = SpriteSheet(
        image: spriteImages,
        srcSize: Vector2(georgeSizeWidth, georgeSizeHeight));
    // sprite = spriteSheet.getSprite(0, 0);
    final spriteSheetOfRuning = SpriteSheet(
        image: await Flame.images.load("Run.png"),
        srcSize: Vector2(georgeSizeWidth, georgeSizeHeight));
    position = Vector2(centerX, centerY);
    size = Vector2(georgeSizeWidth, georgeSizeHeight);

    animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2);
    georgeDownAnimation =
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2);
    georgeLeftAnimation = animation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.2);
    georgeUpAnimation =
        animation = spriteSheet.createAnimation(row: 0, stepTime: 0.2);
    georgeRightAnimation =
        animation = spriteSheetOfRuning.createAnimation(row: 0, stepTime: 0.2);

    // changeDirection();
    return super.onLoad();
  }

  void changeDirection() {
    Random random = Random();
    int newDirection = random.nextInt(4);
    switch (newDirection) {
      case down:
        animation = georgeDownAnimation;
        break;
      case left:
        animation = georgeLeftAnimation;
        break;
      case up:
        animation = georgeUpAnimation;
        break;
      case right:
        animation = georgeRightAnimation;
        break;
    }
    currentDirection = newDirection;
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    elapsedTime += deltaTime;
    if (elapsedTime > 3.0) {
      changeDirection();
      elapsedTime = 0.0;
    }
    switch (currentDirection) {
      case down:
        position.y += georgeSpeed * deltaTime;
        break;
      case left:
        position.x -= georgeSpeed * deltaTime;
        break;
      case up:
        position.y -= georgeSpeed * deltaTime;
        break;
      case right:
        position.x += georgeSpeed * deltaTime;
        break;
    }
  }
}

extension CreateAnimationByColumn on SpriteSheet {
  SpriteAnimation createAnimationByColumn({
    required int column,
    required double stepTime,
    bool loop = true,
    int from = 0,
    int? to,
  }) {
    to ??= columns;
    final spriteList = List<int>.generate(to - from, (i) => from + i)
        .map((e) => getSprite(e, column))
        .toList();
    return SpriteAnimation.spriteList(
      spriteList,
      stepTime: stepTime,
      loop: loop,
    );
  }
}
