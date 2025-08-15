import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/models/card_model.dart';

void main() {
  group('CardModel API-First Structure Tests', () {
    test('handles API response structure directly', () {
      final apiJson = {
        'id': 25,
        'name': 'pikachu',
        'types': [
          {
            'type': {'name': 'electric'}
          }
        ],
        'sprites': {'front_default': 'https://example.com/pikachu.png'}
      };

      final card = CardModel.fromJson(apiJson);

      expect(card.id, '25');
      expect(card.name, 'pikachu');
      expect(card.type1, 'electric');
      expect(card.type2, isNull);
      expect(card.sprite, 'https://example.com/pikachu.png');
    });

    test('handles dual-type Pokemon correctly', () {
      final apiJson = {
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
        'sprites': {'front_default': 'https://example.com/bulbasaur.png'}
      };

      final card = CardModel.fromJson(apiJson);

      expect(card.id, '1');
      expect(card.name, 'bulbasaur');
      expect(card.type1, 'grass');
      expect(card.type2, 'poison');
      expect(card.sprite, 'https://example.com/bulbasaur.png');
    });

    test('perfect round-trip: API -> cache -> load', () {
      final apiJson = {
        'id': 150,
        'name': 'mewtwo',
        'types': [
          {
            'type': {'name': 'psychic'}
          }
        ],
        'sprites': {'front_default': 'https://example.com/mewtwo.png'}
      };

      // Create from API
      final originalCard = CardModel.fromJson(apiJson);

      // Serialize to cache (same structure as API)
      final cacheJson = originalCard.toJson();

      // Load from cache
      final cachedCard = CardModel.fromJson(cacheJson);

      // Should be identical
      expect(cachedCard.id, originalCard.id);
      expect(cachedCard.name, originalCard.name);
      expect(cachedCard.type1, originalCard.type1);
      expect(cachedCard.type2, originalCard.type2);
      expect(cachedCard.sprite, originalCard.sprite);

      // Verify the actual values
      expect(cachedCard.id, '150');
      expect(cachedCard.name, 'mewtwo');
      expect(cachedCard.type1, 'psychic');
      expect(cachedCard.type2, isNull);
      expect(cachedCard.sprite, 'https://example.com/mewtwo.png');
    });

    test('handles missing or null data gracefully', () {
      final incompleteJson = {
        'id': 999,
        'name': 'missingno',
        // No types or sprites
      };

      final card = CardModel.fromJson(incompleteJson);

      expect(card.id, '999');
      expect(card.name, 'missingno');
      expect(card.type1, isNull);
      expect(card.type2, isNull);
      expect(card.sprite, isNull);
    });
  });
}
