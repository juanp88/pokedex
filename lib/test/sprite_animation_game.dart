import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:poke_app/test/reusable_sprite_animation.dart';

class SpriteAnimationGame extends FlameGame {
  @override
  Color backgroundColor() => const Color.fromRGBO(100, 150, 200, 1.0);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _createSpriteExamples();
  }

  Future<void> _createSpriteExamples() async {
    // Single animated pokeball using the reusable component
    final animatedPokeball = ReusableSpriteAnimation.horizontal(
      imagePath: 'pokeball_sprite.png',
      frameCount: 3,
      totalWidth: 451,
      frameHeight: 161,
      position: Vector2(
        size.x / 2 - 50,
        size.y / 2 - 53,
      ), // Center the pokeball
      stepTime: 0.3,
      displaySize: Vector2(100, 107),
      loop: true,
    );
    add(animatedPokeball);
  }
}
