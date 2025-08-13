import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/pokemon.dart';
import '../models/card_model.dart';
import '../models/pokemon_model.dart';

class CacheService {
  static const String _pokemonListKey = 'pokemon_list';
  static const String _pokemonDetailsBoxName = 'pokemon_details';
  static const String _pokemonCardsBoxName = 'pokemon_cards';
  static const String _cacheTimestampKey = 'cache_timestamp_';
  static const String _nextUrlKey = 'next_url';

  // Cache expiration time (24 hours)
  static const Duration cacheExpiration = Duration(hours: 24);

  static late Box<String> _pokemonDetailsBox;
  static late Box<String> _pokemonCardsBox;
  static late SharedPreferences _prefs;

  /// Initialize the cache service
  static Future<void> initialize() async {
    await Hive.initFlutter();

    // Open Hive boxes
    _pokemonDetailsBox = await Hive.openBox<String>(_pokemonDetailsBoxName);
    _pokemonCardsBox = await Hive.openBox<String>(_pokemonCardsBoxName);

    // Initialize SharedPreferences
    _prefs = await SharedPreferences.getInstance();
  }

  /// Check if cache is valid (not expired)
  static bool _isCacheValid(String key) {
    final timestamp = _prefs.getInt('$_cacheTimestampKey$key');
    if (timestamp == null) return false;

    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();

    return now.difference(cacheTime) < cacheExpiration;
  }

  /// Set cache timestamp
  static Future<void> _setCacheTimestamp(String key) async {
    await _prefs.setInt(
        '$_cacheTimestampKey$key', DateTime.now().millisecondsSinceEpoch);
  }

  // POKEMON LIST CACHING

  /// Cache the main Pokemon list
  static Future<void> cachePokemonList(
      List<Result> pokemonList, String nextUrl) async {
    try {
      final jsonList = pokemonList.map((pokemon) => pokemon.toJson()).toList();
      await _prefs.setString(_pokemonListKey, jsonEncode(jsonList));
      await _prefs.setString(_nextUrlKey, nextUrl);
      await _setCacheTimestamp(_pokemonListKey);
    } catch (e) {
      debugPrint('Error caching Pokemon list: $e');
    }
  }

  /// Get cached Pokemon list
  static Future<List<Result>?> getCachedPokemonList() async {
    try {
      if (!_isCacheValid(_pokemonListKey)) return null;

      final jsonString = _prefs.getString(_pokemonListKey);
      if (jsonString == null) return null;

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => Result.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error getting cached Pokemon list: $e');
      return null;
    }
  }

  /// Get cached Pokemon list ignoring expiration (for offline support)
  static Future<List<Result>?> getCachedPokemonListOffline() async {
    try {
      final jsonString = _prefs.getString(_pokemonListKey);
      if (jsonString == null) return null;

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => Result.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error getting offline cached Pokemon list: $e');
      return null;
    }
  }

  /// Get cached next URL
  static String? getCachedNextUrl() {
    return _prefs.getString(_nextUrlKey);
  }

  // POKEMON DETAILS CACHING

  /// Cache Pokemon details
  static Future<void> cachePokemonDetails(String name, Pokemon pokemon) async {
    try {
      await _pokemonDetailsBox.put(
          name.toLowerCase(), jsonEncode(pokemon.toJson()));
      await _setCacheTimestamp('pokemon_$name');
    } catch (e) {
      debugPrint('Error caching Pokemon details for $name: $e');
    }
  }

  /// Get cached Pokemon details
  static Future<Pokemon?> getCachedPokemonDetails(String name) async {
    try {
      if (!_isCacheValid('pokemon_$name')) return null;

      final jsonString = _pokemonDetailsBox.get(name.toLowerCase());
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString);
      return Pokemon.fromCachedJson(json);
    } catch (e) {
      debugPrint('Error getting cached Pokemon details for $name: $e');
      return null;
    }
  }

  /// Get cached Pokemon details ignoring expiration (for offline support)
  static Future<Pokemon?> getCachedPokemonDetailsOffline(String name) async {
    try {
      final jsonString = _pokemonDetailsBox.get(name.toLowerCase());
      if (jsonString == null || jsonString.isEmpty) return null;

      final json = jsonDecode(jsonString);
      if (json == null || json is! Map<String, dynamic>) return null;

      return Pokemon.fromCachedJson(json);
    } catch (e) {
      debugPrint('Error getting offline cached Pokemon details for $name: $e');
      // Try to remove corrupted cache entry
      try {
        await _pokemonDetailsBox.delete(name.toLowerCase());
      } catch (_) {}
      return null;
    }
  }

  // POKEMON CARDS CACHING

  /// Cache Pokemon card data
  static Future<void> cachePokemonCard(String name, CardModel card) async {
    try {
      await _pokemonCardsBox.put(name.toLowerCase(), jsonEncode(card.toJson()));
      await _setCacheTimestamp('card_$name');
    } catch (e) {
      debugPrint('Error caching Pokemon card for $name: $e');
    }
  }

  /// Get cached Pokemon card
  static Future<CardModel?> getCachedPokemonCard(String name) async {
    try {
      if (!_isCacheValid('card_$name')) return null;

      final jsonString = _pokemonCardsBox.get(name.toLowerCase());
      if (jsonString == null || jsonString.isEmpty) return null;

      final json = jsonDecode(jsonString);
      if (json == null || json is! Map<String, dynamic>) return null;

      return CardModel.fromJson(json);
    } catch (e) {
      debugPrint('Error getting cached Pokemon card for $name: $e');
      // Try to remove corrupted cache entry
      try {
        await _pokemonCardsBox.delete(name.toLowerCase());
      } catch (_) {}
      return null;
    }
  }

  /// Get cached Pokemon card ignoring expiration (for offline support)
  static Future<CardModel?> getCachedPokemonCardOffline(String name) async {
    try {
      final jsonString = _pokemonCardsBox.get(name.toLowerCase());
      if (jsonString == null || jsonString.isEmpty) return null;

      final json = jsonDecode(jsonString);
      if (json == null || json is! Map<String, dynamic>) return null;

      return CardModel.fromJson(json);
    } catch (e) {
      debugPrint('Error getting offline cached Pokemon card for $name: $e');
      // Try to remove corrupted cache entry
      try {
        await _pokemonCardsBox.delete(name.toLowerCase());
      } catch (_) {}
      return null;
    }
  }

  // CACHE MANAGEMENT

  /// Clear all cached data
  static Future<void> clearAllCache() async {
    try {
      await _pokemonDetailsBox.clear();
      await _pokemonCardsBox.clear();
      await _prefs.clear();
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  /// Clear expired cache entries
  static Future<void> clearExpiredCache() async {
    try {
      final keys =
          _prefs.getKeys().where((key) => key.startsWith(_cacheTimestampKey));

      for (final key in keys) {
        final dataKey = key.replaceFirst(_cacheTimestampKey, '');
        if (!_isCacheValid(dataKey)) {
          await _prefs.remove(key);

          // Remove corresponding data
          if (dataKey.startsWith('pokemon_')) {
            final name = dataKey.replaceFirst('pokemon_', '');
            await _pokemonDetailsBox.delete(name);
          } else if (dataKey.startsWith('card_')) {
            final name = dataKey.replaceFirst('card_', '');
            await _pokemonCardsBox.delete(name);
          }
        }
      }
    } catch (e) {
      debugPrint('Error clearing expired cache: $e');
    }
  }

  /// Get cache statistics
  static Future<Map<String, dynamic>> getCacheStats() async {
    try {
      final pokemonDetailsCount = _pokemonDetailsBox.length;
      final pokemonCardsCount = _pokemonCardsBox.length;
      final hasMainList = _prefs.getString(_pokemonListKey) != null;

      return {
        'pokemon_details_count': pokemonDetailsCount,
        'pokemon_cards_count': pokemonCardsCount,
        'has_main_list': hasMainList,
        'cache_size_mb': await _calculateCacheSize(),
      };
    } catch (e) {
      debugPrint('Error getting cache stats: $e');
      return {};
    }
  }

  /// Calculate approximate cache size in MB
  static Future<double> _calculateCacheSize() async {
    try {
      int totalSize = 0;

      // Calculate Hive boxes size
      for (final value in _pokemonDetailsBox.values) {
        totalSize += value.length * 2; // Approximate UTF-16 encoding
      }

      for (final value in _pokemonCardsBox.values) {
        totalSize += value.length * 2;
      }

      // Calculate SharedPreferences size
      for (final key in _prefs.getKeys()) {
        final value = _prefs.get(key);
        if (value is String) {
          totalSize += value.length * 2;
        }
      }

      return totalSize / (1024 * 1024); // Convert to MB
    } catch (e) {
      debugPrint('Error calculating cache size: $e');
      return 0.0;
    }
  }

  /// Check if Pokemon is cached
  static bool isPokemonCached(String name) {
    return _pokemonDetailsBox.containsKey(name.toLowerCase()) &&
        _isCacheValid('pokemon_$name');
  }

  /// Check if Pokemon card is cached
  static bool isPokemonCardCached(String name) {
    return _pokemonCardsBox.containsKey(name.toLowerCase()) &&
        _isCacheValid('card_$name');
  }
}
