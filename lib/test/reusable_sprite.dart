import 'package:flame/components.dart';

class ReusableSprite extends SpriteComponent {
  final String imagePath;
  final double frameWidth;
  final double frameHeight;
  final Vector2 displaySize;
  final Vector2? srcPosition;

  ReusableSprite({
    required this.imagePath,
    required this.frameWidth,
    required this.frameHeight,
    required Vector2 position,
    Vector2? displaySize,
    this.srcPosition,
  }) : displaySize = displaySize ?? Vector2(frameWidth, frameHeight) {
    this.position = position;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final image = await findGame()!.images.load(imagePath);

    sprite = Sprite(
      image,
      srcPosition: srcPosition ?? Vector2.zero(),
      srcSize: Vector2(frameWidth, frameHeight),
    );

    size = displaySize;
  }

  /// Factory constructor for extracting a specific frame from a sprite sheet
  factory ReusableSprite.fromSpriteSheet({
    required String imagePath,
    required double frameWidth,
    required double frameHeight,
    required Vector2 position,
    required int frameIndex,
    int? amountPerRow,
    Vector2? displaySize,
  }) {
    Vector2 srcPosition;

    if (amountPerRow != null) {
      // Grid-based sprite sheet
      final row = frameIndex ~/ amountPerRow;
      final col = frameIndex % amountPerRow;
      srcPosition = Vector2(col * frameWidth, row * frameHeight);
    } else {
      // Horizontal sprite sheet
      srcPosition = Vector2(frameIndex * frameWidth, 0);
    }

    return ReusableSprite(
      imagePath: imagePath,
      frameWidth: frameWidth,
      frameHeight: frameHeight,
      position: position,
      displaySize: displaySize,
      srcPosition: srcPosition,
    );
  }
}
