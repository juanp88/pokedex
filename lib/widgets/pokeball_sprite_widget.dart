import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// Simple pokeball sprite animation widget based on the working test implementation
class PokeballSpriteWidget extends StatelessWidget {
  final double size;
  final double animationSpeed;

  const PokeballSpriteWidget({
    super.key,
    this.size = 80.0,
    this.animationSpeed = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: GameWidget<PokeballSpriteGame>.controlled(
        gameFactory: () => PokeballSpriteGame(
          size: size,
          stepTime: animationSpeed,
        ),
      ),
    );
  }
}

class PokeballSpriteGame extends FlameGame {
  final double spriteSize;
  final double stepTime;

  PokeballSpriteGame({required double size, required this.stepTime})
      : spriteSize = size;

  @override
  Color backgroundColor() => const Color(0x00000000); // Transparent

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Create pokeball animation using the exact same pattern as your working test
    final pokeball = PokeballSpriteAnimation(
      imagePath: 'pokeball_pixel_sprites.png',
      frameCount: 3,
      position: Vector2(spriteSize / 2, spriteSize / 2),
      stepTime: stepTime,
      displaySize: Vector2(spriteSize, spriteSize),
      loop: true,
    );

    add(pokeball);
  }
}

/// Exact copy of your working ReusableSpriteAnimation but renamed for pokeball
class PokeballSpriteAnimation extends SpriteAnimationComponent {
  final String imagePath;
  final int frameCount;
  final double stepTime;
  final Vector2 displaySize;
  final bool loop;

  PokeballSpriteAnimation({
    required this.imagePath,
    required this.frameCount,
    required Vector2 position,
    this.stepTime = 0.3,
    Vector2? displaySize,
    this.loop = true,
  }) : displaySize = displaySize ?? Vector2(100, 100) {
    this.position = position;
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final image = await findGame()!.images.load(imagePath);

    // Auto-calculate frame dimensions from the loaded image
    final frameWidth = image.width.toDouble() / frameCount;
    final frameHeight = image.height.toDouble();

    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: frameCount,
        stepTime: stepTime,
        textureSize: Vector2(frameWidth, frameHeight),
        loop: loop,
      ),
    );

    size = displaySize;
  }
}
