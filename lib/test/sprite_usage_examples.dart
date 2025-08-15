import 'package:flame/components.dart';
import 'package:poke_app/test/reusable_sprite.dart';
import 'package:poke_app/test/reusable_sprite_animation.dart';

/// This file contains examples of how to use the reusable sprite components
/// with different types of sprite sheets and configurations.

class SpriteUsageExamples {
  /// Example 1: Horizontal sprite sheet (frames in a single row)
  /// Use this for sprite sheets like: [frame1][frame2][frame3]
  static ReusableSpriteAnimation createHorizontalAnimation({
    required String imagePath,
    required int frameCount,
    required double totalWidth,
    required double frameHeight,
    required Vector2 position,
    double stepTime = 0.3,
    Vector2? displaySize,
  }) {
    return ReusableSpriteAnimation.horizontal(
      imagePath: imagePath,
      frameCount: frameCount,
      totalWidth: totalWidth,
      frameHeight: frameHeight,
      position: position,
      stepTime: stepTime,
      displaySize: displaySize,
    );
  }

  /// Example 2: Grid-based sprite sheet (frames in rows and columns)
  /// Use this for sprite sheets like:
  /// [frame1][frame2][frame3]
  /// [frame4][frame5][frame6]
  static ReusableSpriteAnimation createGridAnimation({
    required String imagePath,
    required int frameCount,
    required int amountPerRow,
    required double frameWidth,
    required double frameHeight,
    required Vector2 position,
    double stepTime = 0.3,
    Vector2? displaySize,
  }) {
    return ReusableSpriteAnimation.grid(
      imagePath: imagePath,
      frameCount: frameCount,
      amountPerRow: amountPerRow,
      frameWidth: frameWidth,
      frameHeight: frameHeight,
      position: position,
      stepTime: stepTime,
      displaySize: displaySize,
    );
  }

  /// Example 3: Static sprite from a single image
  /// Use this for single frame images
  static ReusableSprite createStaticSprite({
    required String imagePath,
    required double frameWidth,
    required double frameHeight,
    required Vector2 position,
    Vector2? displaySize,
  }) {
    return ReusableSprite(
      imagePath: imagePath,
      frameWidth: frameWidth,
      frameHeight: frameHeight,
      position: position,
      displaySize: displaySize,
    );
  }

  /// Example 4: Extract specific frame from sprite sheet as static sprite
  /// Use this to show a specific frame without animation
  static ReusableSprite createStaticFromSpriteSheet({
    required String imagePath,
    required double frameWidth,
    required double frameHeight,
    required Vector2 position,
    required int frameIndex,
    int? amountPerRow, // null for horizontal sheets
    Vector2? displaySize,
  }) {
    return ReusableSprite.fromSpriteSheet(
      imagePath: imagePath,
      frameWidth: frameWidth,
      frameHeight: frameHeight,
      position: position,
      frameIndex: frameIndex,
      amountPerRow: amountPerRow,
      displaySize: displaySize,
    );
  }

  /// Example 5: Character walking animation (common use case)
  /// Assumes a horizontal sprite sheet with walking frames
  static ReusableSpriteAnimation createWalkingAnimation({
    required String characterImagePath,
    required int walkFrames,
    required double totalWidth,
    required double frameHeight,
    required Vector2 position,
    Vector2? displaySize,
  }) {
    return ReusableSpriteAnimation.horizontal(
      imagePath: characterImagePath,
      frameCount: walkFrames,
      totalWidth: totalWidth,
      frameHeight: frameHeight,
      position: position,
      stepTime: 0.2, // Good speed for walking
      displaySize: displaySize,
      loop: true,
    );
  }

  /// Example 6: Explosion or effect animation (plays once)
  /// Use this for effects that should play once and disappear
  static ReusableSpriteAnimation createExplosionAnimation({
    required String explosionImagePath,
    required int frameCount,
    required double frameWidth,
    required double frameHeight,
    required Vector2 position,
    int? amountPerRow,
    Vector2? displaySize,
  }) {
    if (amountPerRow != null) {
      return ReusableSpriteAnimation.grid(
        imagePath: explosionImagePath,
        frameCount: frameCount,
        amountPerRow: amountPerRow,
        frameWidth: frameWidth,
        frameHeight: frameHeight,
        position: position,
        stepTime: 0.1, // Fast explosion
        displaySize: displaySize,
        loop: false, // Play once
      );
    } else {
      return ReusableSpriteAnimation.horizontal(
        imagePath: explosionImagePath,
        frameCount: frameCount,
        totalWidth: frameCount * frameWidth,
        frameHeight: frameHeight,
        position: position,
        stepTime: 0.1,
        displaySize: displaySize,
        loop: false,
      );
    }
  }
}

/// Usage in your game:
/// 
/// // Horizontal sprite sheet example (like your pokeball)
/// final pokeball = SpriteUsageExamples.createHorizontalAnimation(
///   imagePath: 'pokeball_sprite.png',
///   frameCount: 3,
///   totalWidth: 451,
///   frameHeight: 161,
///   position: Vector2(100, 100),
///   displaySize: Vector2(100, 107),
/// );
/// add(pokeball);
/// 
/// // Grid sprite sheet example (4x4 grid with 16 frames)
/// final gridAnimation = SpriteUsageExamples.createGridAnimation(
///   imagePath: 'character_sheet.png',
///   frameCount: 16,
///   amountPerRow: 4,
///   frameWidth: 64,
///   frameHeight: 64,
///   position: Vector2(200, 100),
/// );
/// add(gridAnimation);
/// 
/// // Static sprite from frame 2 of a sprite sheet
/// final staticFrame = SpriteUsageExamples.createStaticFromSpriteSheet(
///   imagePath: 'pokeball_sprite.png',
///   frameWidth: 451 / 3,
///   frameHeight: 161,
///   position: Vector2(300, 100),
///   frameIndex: 1, // Second frame (0-indexed)
/// );
/// add(staticFrame);