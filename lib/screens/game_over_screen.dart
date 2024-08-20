import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({
    super.key,
    required this.flappyBirdGame,
  });

  final FlappyBirdGame flappyBirdGame;

  static const id = 'gameOver';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              flappyBirdGame.score.text,
              style: const TextStyle(
                fontFamily: 'Game',
                fontSize: 60,
                color: Colors.white,
              ),
            ),
            Image.asset('assets/images/${Assets.gameOver}'),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white),
              onPressed: () {
                flappyBirdGame.bird?.reset();
                flappyBirdGame.overlays.remove(GameOverScreen.id);
                flappyBirdGame.resumeEngine();
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
