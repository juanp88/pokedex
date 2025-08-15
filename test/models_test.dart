import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/models/pokemon.dart';
import 'package:poke_app/models/card_model.dart';
import 'package:poke_app/models/pokemon_model.dart';

void main() {
  group('Pokemon Models Tests', () {
    group('CardModel Tests', () {
      test('CardModel.fromJson creates correct object', () {
        final json = {
          'id': 25,
          'name': 'pikachu',
          'types': [
            {
              'type': {'name': 'electric'}
            }
          ],
          'sprites': {'front_default': 'https://example.com/pikachu.png'}
        };

        final card = CardModel.fromJson(json);

        expect(card.id, '25');
        expect(card.name, 'pikachu');
        expect(card.type1, 'electric');
        expect(card.type2, isNull);
        expect(card.sprite, 'https://example.com/pikachu.png');
      });

      test('CardModel handles dual-type Pokemon', () {
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
          'sprites': {'front_default': 'https://example.com/bulbasaur.png'}
        };

        final card = CardModel.fromJson(json);

        expect(card.type1, 'grass');
        expect(card.type2, 'poison');
      });

      test('CardModel handles missing sprite', () {
        final json = {
          'id': 1,
          'name': 'test',
          'types': [
            {
              'type': {'name': 'normal'}
            }
          ],
          'sprites': {}
        };

        final card = CardModel.fromJson(json);

        expect(card.sprite, isNull);
      });

      test('CardModel.toJson creates correct JSON', () {
        final card = CardModel(
          id: '1',
          name: 'test',
          sprites: {'front_default': 'https://example.com/test.png'},
          types: [
            {
              'type': {'name': 'normal'}
            }
          ],
        );

        final json = card.toJson();

        expect(json['id'], '1');
        expect(json['name'], 'test');
        expect(
            json['sprites']['front_default'], 'https://example.com/test.png');
        expect(json['types'][0]['type']['name'], 'normal');

        // Test computed properties
        expect(card.type1, 'normal');
        expect(card.type2, isNull);
        expect(card.sprite, 'https://example.com/test.png');
      });
    });

    group('Pokemon Model Tests', () {
      test('Pokemon model handles basic properties', () {
        final pokemon = Pokemon(
          id: 25,
          name: 'pikachu',
          height: 4,
          weight: 60,
        );

        expect(pokemon.id, 25);
        expect(pokemon.name, 'pikachu');
        expect(pokemon.height, 4);
        expect(pokemon.weight, 60);
      });

      test('Pokemon.toJson creates correct JSON structure', () {
        final pokemon = Pokemon(
          id: 25,
          name: 'pikachu',
          height: 4,
          weight: 60,
        );

        final json = pokemon.toJson();

        expect(json, isA<Map<String, dynamic>>());
        expect(json['id'], 25);
        expect(json['name'], 'pikachu');
        expect(json['height'], 4);
        expect(json['weight'], 60);
      });
    });

    group('PokemonModel (API Response) Tests', () {
      test('Result.fromJson creates correct object', () {
        final json = {
          'name': 'bulbasaur',
          'url': 'https://pokeapi.co/api/v2/pokemon/1/'
        };

        final result = Result.fromJson(json);

        expect(result.name, 'bulbasaur');
        expect(result.url, 'https://pokeapi.co/api/v2/pokemon/1/');
      });

      test('Result.toJson creates correct JSON', () {
        final result = Result(
          name: 'bulbasaur',
          url: 'https://pokeapi.co/api/v2/pokemon/1/',
        );

        final json = result.toJson();

        expect(json['name'], 'bulbasaur');
        expect(json['url'], 'https://pokeapi.co/api/v2/pokemon/1/');
      });

      test('PokemonsModel.fromJson creates correct object', () {
        final json = {
          'count': 1154,
          'next': 'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20',
          'results': [
            {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'}
          ]
        };

        final pokemonsModel = PokemonsModel.fromJson(json);

        expect(pokemonsModel.count, 1154);
        expect(pokemonsModel.next,
            'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20');
        expect(pokemonsModel.results, hasLength(1));
        expect(pokemonsModel.results?.first.name, 'bulbasaur');
      });
    });
  });
}
