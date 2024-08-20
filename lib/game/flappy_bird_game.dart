import 'dart:async' hide Timer;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/text.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe_group.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection, KeyboardEvents {
  final interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  Bird? bird;
  late TextComponent score = TextComponent(
    text: 'Score 0',
    position: Vector2(size.x / 2, size.y / 2 * 0.2),
    anchor: Anchor.center,
    textRenderer: TextPaint(
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        fontFamily: 'Game',
        color: Colors.white,
      ),
    ),
  );

  @override
  Future<void> onLoad() async {
    bird = Bird();
    await addAll(
      [
        Background(),
        Ground(),
        bird!,
        score,
      ],
    );

    interval.onTick = () => add(PipeGroup());
  }

  @override
  void onTap() {
    super.onTap();
    bird?.fly();
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is KeyDownEvent;
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isKeyDown && isSpace) {
      bird?.fly();
      return KeyEventResult.handled;
    }
    
    return KeyEventResult.ignored;
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score ${bird?.score ?? 0}';
  }
}
