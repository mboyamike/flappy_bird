import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    super.key,
    required this.flappyBirdGame,
  });

  final FlappyBirdGame flappyBirdGame;

  static const String id = 'mainMenu';

  @override
  Widget build(BuildContext context) {
    flappyBirdGame.pauseEngine();
    return Scaffold(
      body: InkWell(
        onTap: () {
          flappyBirdGame.overlays.remove(MainMenuScreen.id);
          flappyBirdGame.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/${Assets.menu}'),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset('assets/images/${Assets.message}'),
        ),
      ),
    );
  }
}
