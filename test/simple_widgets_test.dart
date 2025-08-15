import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/widgets/pokeball_sprite_widget.dart';
import 'package:poke_app/widgets/type_card.dart';

void main() {
  group('Simple Widget Tests', () {
    testWidgets('PokeballSpriteWidget renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PokeballSpriteWidget(
              size: 100,
              animationSpeed: 0.3,
            ),
          ),
        ),
      );

      expect(find.byType(PokeballSpriteWidget), findsOneWidget);
    });

    testWidgets('TypeCard renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TypeCard('fire'),
          ),
        ),
      );

      // TypeCard should render without errors
      expect(find.byType(TypeCard), findsOneWidget);
      // The text is capitalized by the widget
      expect(find.text('Fire'), findsOneWidget);
    });
  });
}
