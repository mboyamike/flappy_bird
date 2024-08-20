import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/pipe_position.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  final PipePosition pipePosition;
  @override
  final double height;

  Pipe({required this.pipePosition, required this.height});

  @override
  FutureOr<void> onLoad() async {
    final (pipe, pipeRotated) = await (
      Flame.images.load(Assets.pipe),
      Flame.images.load(Assets.pipeRotated)
    ).wait;

    size = Vector2(50, height);

    switch (pipePosition) {
      case PipePosition.top:
        sprite = Sprite(pipeRotated);
        position.y = 0;
        break;
      case PipePosition.bottom:
        sprite = Sprite(pipe);
        position.y = gameRef.size.y - size.y - Config.groundHeight;
        break;
    }

    add(RectangleHitbox());
  }
}
