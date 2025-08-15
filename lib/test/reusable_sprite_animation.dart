import 'package:flame/components.dart';

class ReusableSpriteAnimation extends SpriteAnimationComponent {
  final String imagePath;
  final int frameCount;
  final double frameWidth;
  final double frameHeight;
  final double stepTime;
  final Vector2 displaySize;
  final bool loop;
  final int? amountPerRow;

  ReusableSpriteAnimation({
    required this.imagePath,
    required this.frameCount,
    required this.frameWidth,
    required this.frameHeight,
    required Vector2 position,
    this.stepTime = 0.3,
    Vector2? displaySize,
    this.loop = true,
    this.amountPerRow,
  }) : displaySize = displaySize ?? Vector2(frameWidth, frameHeight) {
    this.position = position;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final image = await findGame()!.images.load(imagePath);

    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: frameCount,
        amountPerRow: amountPerRow,
        stepTime: stepTime,
        textureSize: Vector2(frameWidth, frameHeight),
        loop: loop,
      ),
    );

    size = displaySize;
  }

  /// Factory constructor for horizontal sprite sheets (frames in a single row)
  factory ReusableSpriteAnimation.horizontal({
    required String imagePath,
    required int frameCount,
    required double totalWidth,
    required double frameHeight,
    required Vector2 position,
    double stepTime = 0.3,
    Vector2? displaySize,
    bool loop = true,
  }) {
    final frameWidth = totalWidth / frameCount;
    return ReusableSpriteAnimation(
      imagePath: imagePath,
      frameCount: frameCount,
      frameWidth: frameWidth,
      frameHeight: frameHeight,
      position: position,
      stepTime: stepTime,
      displaySize: displaySize,
      loop: loop,
    );
  }

  /// Factory constructor for grid-based sprite sheets
  factory ReusableSpriteAnimation.grid({
    required String imagePath,
    required int frameCount,
    required int amountPerRow,
    required double frameWidth,
    required double frameHeight,
    required Vector2 position,
    double stepTime = 0.3,
    Vector2? displaySize,
    bool loop = true,
  }) {
    return ReusableSpriteAnimation(
      imagePath: imagePath,
      frameCount: frameCount,
      frameWidth: frameWidth,
      frameHeight: frameHeight,
      position: position,
      stepTime: stepTime,
      displaySize: displaySize,
      loop: loop,
      amountPerRow: amountPerRow,
    );
  }

  /// Factory constructor for single frame (static sprite)
  factory ReusableSpriteAnimation.static({
    required String imagePath,
    required double frameWidth,
    required double frameHeight,
    required Vector2 position,
    Vector2? displaySize,
  }) {
    return ReusableSpriteAnimation(
      imagePath: imagePath,
      frameCount: 1,
      frameWidth: frameWidth,
      frameHeight: frameHeight,
      position: position,
      stepTime: 1.0, // Doesn't matter for static
      displaySize: displaySize,
      loop: false,
    );
  }
}
