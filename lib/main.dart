import 'package:flame/game.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/screens/game_over_screen.dart';
import 'package:flappy_bird/screens/main_menu_screen.dart';
import 'package:flutter/material.dart';

void main() {
  final game = FlappyBirdGame();

  runApp(
    MaterialApp(
      home: GameWidget(
        game: game,
        initialActiveOverlays: const [MainMenuScreen.id],
        overlayBuilderMap: {
          MainMenuScreen.id: (_, __) => MainMenuScreen(flappyBirdGame: game),
          GameOverScreen.id: (_, __) => GameOverScreen(flappyBirdGame: game),
        },
      ),
    ),
  );
}
