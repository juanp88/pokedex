import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/widgets/pokeball_sprite_widget.dart';
import 'package:poke_app/widgets/type_card.dart';
import 'package:poke_app/widgets/home_header.dart';

void main() {
  group('Widget Tests', () {
    group('PokeballSpriteWidget Tests', () {
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

      testWidgets('PokeballSpriteWidget handles different sizes',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  PokeballSpriteWidget(size: 50, animationSpeed: 0.3),
                  PokeballSpriteWidget(size: 100, animationSpeed: 0.3),
                  PokeballSpriteWidget(size: 150, animationSpeed: 0.3),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(PokeballSpriteWidget), findsNWidgets(3));
      });
    });

    group('TypeCard Tests', () {
      testWidgets('TypeCard displays type name', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TypeCard('fire'),
            ),
          ),
        );

        expect(find.text('fire'), findsOneWidget);
        expect(find.byType(TypeCard), findsOneWidget);
      });

      testWidgets('TypeCard handles empty string type',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TypeCard(''),
            ),
          ),
        );

        expect(find.byType(TypeCard), findsOneWidget);
        // Should still render the widget even with empty string
        expect(find.text(''), findsOneWidget);
      });

      testWidgets('TypeCard handles different types',
          (WidgetTester tester) async {
        const types = ['fire', 'water', 'grass', 'electric', 'psychic'];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: types.map((type) => TypeCard(type)).toList(),
              ),
            ),
          ),
        );

        for (final type in types) {
          expect(
              find.text(type.substring(0, 1).toUpperCase() + type.substring(1)),
              findsOneWidget);
        }
        expect(find.byType(TypeCard), findsNWidgets(types.length));
      });

      testWidgets('TypeCard conditional rendering like in Pokemon cards',
          (WidgetTester tester) async {
        // Simulate how TypeCard is used in the actual app
        String? type1 = 'fire';
        String? type2 = 'flying';
        String? type3; // null type

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  if (type1 != null) TypeCard(type1),
                  const SizedBox(width: 5),
                  if (type2 != null) TypeCard(type2),
                  if (type3 != null) TypeCard(type3), // This won't render
                ],
              ),
            ),
          ),
        );

        expect(
            find.byType(TypeCard), findsNWidgets(2)); // Only 2 cards rendered
        expect(find.text('Fire'), findsOneWidget);
        expect(find.text('Flying'), findsOneWidget);
      });
    });

    group('HomeHeader Tests', () {
      testWidgets('HomeHeader renders correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: HomeHeader(),
            ),
          ),
        );

        expect(find.byType(HomeHeader), findsOneWidget);
      });
    });
  });

  group('Widget Integration Tests', () {
    testWidgets('Multiple widgets work together', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                HomeHeader(),
                PokeballSpriteWidget(size: 80, animationSpeed: 0.3),
                Row(
                  children: [
                    TypeCard('fire'),
                    TypeCard('water'),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(HomeHeader), findsOneWidget);
      expect(find.byType(PokeballSpriteWidget), findsOneWidget);
      expect(find.byType(TypeCard), findsNWidgets(2));
      expect(find.text('fire'), findsOneWidget);
      expect(find.text('water'), findsOneWidget);
    });
  });
}
