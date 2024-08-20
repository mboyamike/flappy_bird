import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/pipe_position.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  final _random = Random();

  @override
  FutureOr<void> onLoad() {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 150 + _random.nextDouble() * heightMinusGround / 4;
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);

    addAll(
      [
        Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
        Pipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGround - (centerY + spacing / 2),
        ),
      ],
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;
    if (position.x < -20 || gameRef.isHit) {
      removeFromParent();
      gameRef.bird?.updateScore(null);
      gameRef.isHit = false;
    }

    if (position.x == gameRef.bird?.position.x) {
      gameRef.bird?.updateScore(null);
    }
  }
}
