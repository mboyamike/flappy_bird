import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/bird_movement.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/screens/game_over_screen.dart';
import 'package:flutter/widgets.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  int score = 0;

  @override
  FutureOr<void> onLoad() async {
    final (birdMidFlap, birdUpFlap, birdDownFlap) = await (
      gameRef.loadSprite(Assets.birdMidFlap),
      gameRef.loadSprite(Assets.birdUpFlap),
      gameRef.loadSprite(Assets.birdDownFlap)
    ).wait;

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.down;
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };

    add(CircleHitbox());
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  void gameOver() {
    FlameAudio.play(Assets.gameOver);
    gameRef.pauseEngine();
    gameRef.overlays.add(GameOverScreen.id);
    gameRef.isHit = true;
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );
    FlameAudio.play(Assets.flying);
    current = BirdMovement.up;
  }

  void updateScore(int? newScore) {
    score = newScore ?? (score + 1);
    gameRef.score.text = 'Score $score';
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    updateScore(0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
    
    if (position.y < 0) {
      gameOver();
    }
  }
}
