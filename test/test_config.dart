import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Test configuration and utilities for the Pokemon app tests
class TestConfig {
  /// Initialize test environment
  static Future<void> initialize() async {
    // Set up Hive for testing
    Hive.init('test');

    // Set up SharedPreferences mock
    SharedPreferences.setMockInitialValues({});

    // Ensure Flutter binding is initialized
    TestWidgetsFlutterBinding.ensureInitialized();
  }

  /// Clean up test environment
  static Future<void> cleanup() async {
    try {
      await Hive.deleteFromDisk();
    } catch (e) {
      // Ignore cleanup errors in tests
    }
  }

  /// Mock Pokemon data for testing
  static Map<String, dynamic> get mockPokemonJson => {
        'id': 25,
        'name': 'pikachu',
        'height': 4,
        'weight': 60,
        'types': [
          {
            'type': {'name': 'electric'}
          }
        ],
        'sprites': {
          'front_default':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
          'other': {
            'official-artwork': {
              'front_default':
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png'
            }
          }
        },
        'stats': [
          {
            'base_stat': 35,
            'stat': {'name': 'hp'}
          },
          {
            'base_stat': 55,
            'stat': {'name': 'attack'}
          },
          {
            'base_stat': 40,
            'stat': {'name': 'defense'}
          },
          {
            'base_stat': 50,
            'stat': {'name': 'special-attack'}
          },
          {
            'base_stat': 50,
            'stat': {'name': 'special-defense'}
          },
          {
            'base_stat': 90,
            'stat': {'name': 'speed'}
          }
        ]
      };

  /// Mock Pokemon list response
  static Map<String, dynamic> get mockPokemonListJson => {
        'count': 1154,
        'next': 'https://pokeapi.co/api/v2/pokemon?offset=20&limit=20',
        'previous': null,
        'results': [
          {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
          {'name': 'ivysaur', 'url': 'https://pokeapi.co/api/v2/pokemon/2/'},
          {'name': 'venusaur', 'url': 'https://pokeapi.co/api/v2/pokemon/3/'}
        ]
      };

  /// Mock species data
  static Map<String, dynamic> get mockSpeciesJson => {
        'id': 25,
        'name': 'pikachu',
        'flavor_text_entries': [
          {
            'flavor_text':
                'When several of these POKéMON gather, their electricity could build and cause lightning storms.',
            'language': {'name': 'en'}
          }
        ],
        'genera': [
          {
            'genus': 'Mouse Pokémon',
            'language': {'name': 'en'}
          }
        ]
      };

  /// Test Pokemon types for color testing
  static List<String> get allPokemonTypes => [
        'normal',
        'fire',
        'water',
        'electric',
        'grass',
        'ice',
        'fighting',
        'poison',
        'ground',
        'flying',
        'psychic',
        'bug',
        'rock',
        'ghost',
        'dragon',
        'dark',
        'steel',
        'fairy'
      ];

  /// Expected colors for each type (for testing color mapping)
  static Map<String, int> get expectedCardColors => {
        'fire': 0xfffa9950,
        'grass': 0xff91eb5b,
        'water': 0xFF69b9e3,
        'rock': 0xffedd040,
        'bug': 0xffbed41c,
        'normal': 0xffC6C6A7,
        'poison': 0xffd651d4,
        'electric': 0xffF7D02C,
        'ground': 0xfff5d37d,
        'ice': 0xff79dbdb,
        'dark': 0xffa37e65,
        'fairy': 0xfffaa7d0,
        'psychic': 0xffff80a6,
        'fighting': 0xffe8413a,
        'ghost': 0xff9063c9,
        'flying': 0xffbda8f7,
        'dragon': 0xff9065f7,
        'steel': 0xffa0a0de,
      };
}
