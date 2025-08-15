import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:poke_app/models/pokemon_model.dart';
import 'package:poke_app/services/pokemon_service.dart';
import 'package:poke_app/services/cache_service.dart';
import 'package:poke_app/utils/api_status.dart';

import '../models/card_model.dart';
import '../models/pokemon.dart';
import '../models/pokemons_detail_model.dart';

class PokemonViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoadingMore = false;
  var _pokemonListModel = [];
  var _nextUrl = '';

  // Use maps to maintain order by index
  final Map<int, CardModel> _pokeMap = {};
  final Map<int, Pokemon> _pokemonsDetailMap = {};

  Pokemon pokemon = Pokemon();

  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  List get pokemonListModel => _pokemonListModel;

  // Convert maps to lists for UI, maintaining order
  List<CardModel> get pokeList {
    List<CardModel> list = [];
    for (int i = 0; i < _pokemonListModel.length; i++) {
      if (_pokeMap.containsKey(i)) {
        list.add(_pokeMap[i]!);
      }
    }
    return list;
  }

  List<Pokemon> get pokemonsDetail {
    List<Pokemon> list = [];
    for (int i = 0; i < _pokemonListModel.length; i++) {
      if (_pokemonsDetailMap.containsKey(i)) {
        list.add(_pokemonsDetailMap[i]!);
      }
    }
    return list;
  }

  // Check if a specific index has loaded data
  bool hasDataAtIndex(int index) {
    return _pokeMap.containsKey(index) && _pokemonsDetailMap.containsKey(index);
  }

  PokemonViewModel() {
    getPokemons();
  }

  void setPokemonListModel(pokemonListModel) {
    _pokemonListModel = pokemonListModel;
  }

  void setCardListModel(int index, CardModel pokemonDetail) {
    _pokeMap[index] = pokemonDetail;
  }

  void setPokemonDetail(int index, Pokemon pokemonDetail) {
    _pokemonsDetailMap[index] = pokemonDetail;
  }

  Future<void> getPokemons() async {
    _isLoading = true;
    notifyListeners();

    // Try to load from cache first (valid cache)
    final cachedList = await CacheService.getCachedPokemonList();
    if (cachedList != null) {
      debugPrint('Loading Pokemon list from valid cache');
      _nextUrl = CacheService.getCachedNextUrl() ?? '';
      setPokemonListModel(cachedList);
      _setUsingCache(true);
      _isLoading = false;
      notifyListeners();

      // Load details asynchronously
      _loadPokemonDetailsAsync();
      return;
    }

    // Try to load from offline cache (ignores expiration)
    final offlineCachedList = await CacheService.getCachedPokemonListOffline();
    if (offlineCachedList != null) {
      debugPrint('Loading Pokemon list from offline cache');
      _nextUrl = CacheService.getCachedNextUrl() ?? '';
      setPokemonListModel(offlineCachedList);
      _setUsingCache(true);
      _isLoading = false;
      notifyListeners();

      // Load details asynchronously
      _loadPokemonDetailsAsync();
      return;
    }

    // If no cache, fetch from API
    debugPrint('Loading Pokemon list from API');
    var response = await PokemonService.getPokemons();
    if (response is Success) {
      var data = response.response as Map<String, dynamic>;
      var pokemonResponse = PokemonsModel.fromJson(data);

      _nextUrl = pokemonResponse.next.toString();
      setPokemonListModel(pokemonResponse.results);

      // Cache the list
      await CacheService.cachePokemonList(pokemonResponse.results!, _nextUrl);

      // Load details asynchronously without blocking UI
      _loadPokemonDetailsAsync();
    } else {
      // API failed - try to load any cached data (even expired) for offline support
      debugPrint(
          'API failed, checking for any cached data for offline support');
      final expiredCachedList = await _getExpiredCachedData();
      if (expiredCachedList != null) {
        debugPrint('Loading expired cache for offline support');
        _nextUrl = CacheService.getCachedNextUrl() ?? '';
        setPokemonListModel(expiredCachedList);
        _setUsingCache(true);
        _loadPokemonDetailsAsync();
      } else {
        debugPrint('No cached data available - showing empty state');
        // Show empty state or error message
        _showOfflineMessage();
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  void _loadPokemonDetailsAsync() async {
    for (int i = 0; i < pokemonListModel.length; i++) {
      final result = pokemonListModel[i];
      // Load each Pokemon detail with index to maintain order
      getPokemonDetails(index: i, name: result.name!).then((_) {
        notifyListeners(); // Update UI as each Pokemon loads
      });
    }
  }

  Future<void> getMorePokemons() async {
    if (_isLoadingMore) return; // Prevent multiple simultaneous calls

    _isLoadingMore = true;
    notifyListeners();

    String url = _nextUrl;
    if (pokemonListModel.length > 0) {
      var response = await PokemonService.getMorePokemons(url);
      if (response is Success) {
        var list = response.response as PokemonsModel;
        _nextUrl = list.next.toString();

        final startIndex = _pokemonListModel.length;
        // Add new Pokemon to the list first
        _pokemonListModel.addAll(list.results as Iterable);
        _isLoadingMore = false;
        notifyListeners();

        // Load details asynchronously with proper indexing
        for (int i = 0; i < list.results!.length; i++) {
          final result = list.results![i];
          final index = startIndex + i;
          getPokemonDetails(index: index, name: result.name!).then((_) {
            notifyListeners();
          });
        }
      } else {
        _isLoadingMore = false;
        notifyListeners();
      }
    }
  }

  Future<Pokemon> getPokemonDetails(
      {required int index, required String name}) async {
    // If we're using cache (offline mode), prioritize offline cache
    if (_isUsingCache) {
      final offlinePokemon =
          await CacheService.getCachedPokemonDetailsOffline(name);
      final offlineCard = await CacheService.getCachedPokemonCardOffline(name);

      if (offlinePokemon != null && offlineCard != null) {
        debugPrint('Loading $name from offline cache (priority mode)');
        setCardListModel(index, offlineCard);
        setPokemonDetail(index, offlinePokemon);
        return offlinePokemon;
      }
    }

    // Try to load from valid cache first
    final cachedPokemon = await CacheService.getCachedPokemonDetails(name);
    final cachedCard = await CacheService.getCachedPokemonCard(name);

    if (cachedPokemon != null && cachedCard != null) {
      debugPrint('Loading $name from valid cache');
      setCardListModel(index, cachedCard);
      setPokemonDetail(index, cachedPokemon);
      return cachedPokemon;
    }

    // If not in cache, fetch from API
    debugPrint('Loading $name from API');
    var response = await PokemonService.getPokemonsDetail(name: name);

    if (response is Success) {
      var data1 = response.response as Map<String, dynamic>;
      var detailResponse = PokemonDetailModel.fromJson(data1);

      final cardModel = CardModel.fromJson(data1);
      setCardListModel(index, cardModel);

      var secResponse =
          await PokemonService.getSpeciesDetails(detailResponse.id!);
      var data2 = secResponse.response as Map<String, dynamic>;
      if (secResponse is Success) {
        pokemon = Pokemon.fromJson(data1, data2);
        setPokemonDetail(index, pokemon);

        // Cache the results
        await CacheService.cachePokemonDetails(name, pokemon);
        await CacheService.cachePokemonCard(name, cardModel);

        // Pre-cache images for offline use
        _preCacheImages(pokemon, cardModel);
      }
    } else {
      // API failed - try offline cache
      debugPrint('API failed for $name, trying offline cache');
      final offlinePokemon =
          await CacheService.getCachedPokemonDetailsOffline(name);
      final offlineCard = await CacheService.getCachedPokemonCardOffline(name);

      if (offlinePokemon != null && offlineCard != null) {
        debugPrint('Loading $name from offline cache');
        setCardListModel(index, offlineCard);
        setPokemonDetail(index, offlinePokemon);
        return offlinePokemon;
      }
    }
    return pokemon;
  }

  // Separate method for search functionality
  Future<Pokemon?> searchPokemonByName({required String name}) async {
    // Try cache first for search too
    final cachedPokemon = await CacheService.getCachedPokemonDetails(name);
    if (cachedPokemon != null) {
      debugPrint('Search result for $name loaded from cache');
      return cachedPokemon;
    }

    // If not cached, fetch from API
    debugPrint('Search result for $name loaded from API');
    var response = await PokemonService.getPokemonsDetail(name: name);

    if (response is Success) {
      var data1 = response.response as Map<String, dynamic>;
      var detailResponse = PokemonDetailModel.fromJson(data1);

      var secResponse =
          await PokemonService.getSpeciesDetails(detailResponse.id!);
      var data2 = secResponse.response as Map<String, dynamic>;
      if (secResponse is Success) {
        final pokemon = Pokemon.fromJson(data1, data2);

        // Cache the search result
        final cardModel = CardModel.fromJson(data1);
        await CacheService.cachePokemonDetails(name, pokemon);
        await CacheService.cachePokemonCard(name, cardModel);

        // Pre-cache images for offline use
        _preCacheImages(pokemon, cardModel);

        return pokemon;
      }
    } else {
      // API failed - try offline cache for search
      debugPrint('Search API failed for $name, trying offline cache');
      final offlinePokemon =
          await CacheService.getCachedPokemonDetailsOffline(name);
      if (offlinePokemon != null) {
        debugPrint('Search result for $name loaded from offline cache');
        return offlinePokemon;
      }
    }
    return null;
  }

  // Cache management methods
  Future<void> clearCache() async {
    await CacheService.clearAllCache();
    // Reset local data
    _pokemonListModel.clear();
    _pokeMap.clear();
    _pokemonsDetailMap.clear();
    _nextUrl = '';

    // Reset offline state to ensure fresh fetch
    resetOfflineState();

    // Automatically trigger fresh data fetch
    await getPokemons();
  }

  Future<Map<String, dynamic>> getCacheStats() async {
    return await CacheService.getCacheStats();
  }

  Future<void> clearExpiredCache() async {
    await CacheService.clearExpiredCache();
  }

  /// Pre-cache images for all currently loaded Pokemon
  Future<void> preCacheAllImages() async {
    debugPrint(
        'Starting bulk image pre-caching for ${pokemonsDetail.length} Pokemon');

    final pokemonList = pokemonsDetail;
    final cardList = pokeList;

    if (pokemonList.isNotEmpty && cardList.isNotEmpty) {
      await _preCacheMultipleImages(pokemonList, cardList);
      debugPrint('Completed bulk image pre-caching');
    }
  }

  // Offline support methods
  Future<List<Result>?> _getExpiredCachedData() async {
    return await CacheService.getCachedPokemonListOffline();
  }

  void _showOfflineMessage() {
    // Set a flag to show offline message in UI
    _isOffline = true;
    notifyListeners();
  }

  // Add offline state management
  bool _isOffline = false;
  bool _isUsingCache = false;

  bool get isOffline => _isOffline;
  bool get isUsingCache => _isUsingCache;

  void resetOfflineState() {
    _isOffline = false;
    _isUsingCache = false;
    notifyListeners();
  }

  void _setUsingCache(bool usingCache) {
    _isUsingCache = usingCache;
    notifyListeners();
  }

  /// Pre-cache Pokemon images for offline use
  Future<void> _preCacheImages(Pokemon pokemon, CardModel card) async {
    try {
      // Cache the card sprite (list view image)
      if (card.sprite != null && card.sprite!.isNotEmpty) {
        await DefaultCacheManager().downloadFile(card.sprite!);
        debugPrint('Pre-cached sprite for ${pokemon.name}');
      }

      // Cache the official artwork (detail view image)
      if (pokemon.sprites?.other?.officialArtwork?.frontDefault != null) {
        final artworkUrl =
            pokemon.sprites!.other!.officialArtwork!.frontDefault!;
        await DefaultCacheManager().downloadFile(artworkUrl);
        debugPrint('Pre-cached artwork for ${pokemon.name}');
      }
    } catch (e) {
      debugPrint('Error pre-caching images for ${pokemon.name}: $e');
    }
  }

  /// Pre-cache images for multiple Pokemon
  Future<void> _preCacheMultipleImages(
      List<Pokemon> pokemonList, List<CardModel> cardList) async {
    for (int i = 0; i < pokemonList.length && i < cardList.length; i++) {
      await _preCacheImages(pokemonList[i], cardList[i]);
      // Small delay to prevent overwhelming the system
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}
