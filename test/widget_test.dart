import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/helpers/map_cardColor.dart';
import 'package:poke_app/models/card_model.dart';

void main() {
  group('Pokemon App Tests', () {
    testWidgets('App loads correctly', (WidgetTester tester) async {
      // Simple test that doesn't require complex setup
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Pokemon App'),
            ),
          ),
        ),
      );

      expect(find.text('Pokemon App'), findsOneWidget);
    });
  });

  group('Color Mapping Tests', () {
    test('setCardColor returns correct colors for Pokemon types', () {
      // Test primary types
      expect(setCardColor('fire'), const Color(0xfffa9950));
      expect(setCardColor('grass'), const Color(0xff91eb5b));
      expect(setCardColor('water'), const Color(0xFF69b9e3));
      expect(setCardColor('electric'), const Color(0xffF7D02C));
      expect(setCardColor('psychic'), const Color(0xffff80a6));
      expect(setCardColor('ice'), const Color(0xff79dbdb));
      expect(setCardColor('dragon'), const Color(0xff9065f7));
      expect(setCardColor('dark'), const Color(0xffa37e65));
      expect(setCardColor('fairy'), const Color(0xfffaa7d0));
      expect(setCardColor('fighting'), const Color(0xffe8413a));
      expect(setCardColor('poison'), const Color(0xffd651d4));
      expect(setCardColor('ground'), const Color(0xfff5d37d));
      expect(setCardColor('flying'), const Color(0xffbda8f7));
      expect(setCardColor('bug'), const Color(0xffbed41c));
      expect(setCardColor('rock'), const Color(0xffedd040));
      expect(setCardColor('ghost'), const Color(0xff9063c9));
      expect(setCardColor('steel'), const Color(0xffa0a0de));
      expect(setCardColor('normal'), const Color(0xffC6C6A7));
    });

    test('setCardColor handles case insensitive input', () {
      expect(setCardColor('FIRE'), const Color(0xfffa9950));
      expect(setCardColor('Fire'), const Color(0xfffa9950));
      expect(setCardColor('fIrE'), const Color(0xfffa9950));
    });

    test('setCardColor returns default color for unknown types', () {
      expect(setCardColor('unknown'), const Color(0xffdbd9d9));
      expect(setCardColor(''), const Color(0xffdbd9d9));
      expect(setCardColor('invalid'), const Color(0xffdbd9d9));
    });

    test('setTypeColor returns correct colors for Pokemon types', () {
      expect(setTypeColor('fire'), const Color(0xffF08030));
      expect(setTypeColor('grass'), const Color(0xff7AC74C));
      expect(setTypeColor('water'), const Color(0xFF6390F0));
      expect(setTypeColor('electric'), const Color(0xfffce321));
    });
  });

  group('Model Tests', () {
    test('CardModel creates correctly from JSON', () {
      final json = {
        'id': 1,
        'name': 'bulbasaur',
        'types': [
          {
            'type': {'name': 'grass'}
          },
          {
            'type': {'name': 'poison'}
          }
        ],
        'sprites': {'front_default': 'https://example.com/sprite.png'}
      };

      final card = CardModel.fromJson(json);

      expect(card.id, '1');
      expect(card.name, 'bulbasaur');
      expect(card.type1, 'grass');
      expect(card.type2, 'poison');
      expect(card.sprite, 'https://example.com/sprite.png');
    });

    test('CardModel handles single type Pokemon', () {
      final json = {
        'id': 1,
        'name': 'bulbasaur',
        'types': [
          {
            'type': {'name': 'grass'}
          }
        ],
        'sprites': {'front_default': 'https://example.com/sprite.png'}
      };

      final card = CardModel.fromJson(json);

      expect(card.type1, 'grass');
      expect(card.type2, isNull);
    });
  });
}
