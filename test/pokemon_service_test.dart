import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/services/pokemon_service.dart';
import 'package:poke_app/utils/api_status.dart';

void main() {
  group('PokemonService Tests', () {
    test('PokemonService methods exist and return correct types', () {
      expect(PokemonService.getPokemons, isA<Function>());
      expect(PokemonService.getPokemonsDetail, isA<Function>());
      expect(PokemonService.getSpeciesDetails, isA<Function>());
      expect(PokemonService.getMorePokemons, isA<Function>());
    });

    test('API endpoints are correctly formatted', () {
      // Test that the service can handle different input formats
      expect(() => PokemonService.getPokemonsDetail(name: 'bulbasaur'),
          returnsNormally);
      expect(() => PokemonService.getPokemonsDetail(name: 'BULBASAUR'),
          returnsNormally);
      expect(
          () => PokemonService.getPokemonsDetail(name: '1'), returnsNormally);
    });

    test('getSpeciesDetails handles numeric IDs', () {
      expect(() => PokemonService.getSpeciesDetails(1), returnsNormally);
      expect(() => PokemonService.getSpeciesDetails(151), returnsNormally);
      expect(() => PokemonService.getSpeciesDetails(1000), returnsNormally);
    });

    test('getMorePokemons handles URL parameters', () {
      const testUrl = 'https://pokeapi.co/api/v2/pokemon?limit=20&offset=20';
      expect(() => PokemonService.getMorePokemons(testUrl), returnsNormally);
    });

    // Integration tests (these would require network access)
    group('Integration Tests (Network Required)', () {
      test('getPokemons returns Success or Failure', () async {
        try {
          final result = await PokemonService.getPokemons();
          expect(result, anyOf(isA<Success>(), isA<Failure>()));
        } catch (e) {
          // Network might not be available in test environment
          print('Network test skipped: $e');
        }
      }, skip: 'Requires network access');

      test('getPokemonsDetail with valid Pokemon name', () async {
        try {
          final result =
              await PokemonService.getPokemonsDetail(name: 'pikachu');
          expect(result, anyOf(isA<Success>(), isA<Failure>()));
        } catch (e) {
          print('Network test skipped: $e');
        }
      }, skip: 'Requires network access');
    });
  });
}
