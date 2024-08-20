import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_bird/game/assets.dart';

class Background extends ParallaxComponent with HasGameRef<FlameGame> {
  Background();

  @override
  FutureOr<void> onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    parallax = Parallax([ParallaxLayer(ParallaxImage(background))]);
    parallax?.baseVelocity.x = 20;
    // sprite = Sprite(background);
  }
}
