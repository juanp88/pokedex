import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:poke_app/test/sprite_animation_game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flame Spritesheet Animation'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Flame game widget
          Expanded(
            child: GameWidget<SpriteAnimationGame>.controlled(
              gameFactory: SpriteAnimationGame.new,
            ),
          ),
          // Control panel
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: const Column(
              children: [
                Text('Reusable Sprite Animation Demo'),
                SizedBox(height: 8),
                Text('Single animated pokeball using ReusableSpriteAnimation'),
                Text('Component can be reused with any sprite sheet!'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
