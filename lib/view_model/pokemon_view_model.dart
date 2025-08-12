import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:poke_app/models/pokemon_model.dart';
import 'package:poke_app/services/pokemon_service.dart';
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
  get pokemonListModel => _pokemonListModel;

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

  setPokemonListModel(pokemonListModel) {
    _pokemonListModel = pokemonListModel;
  }

  setCardListModel(int index, CardModel pokemonDetail) {
    _pokeMap[index] = pokemonDetail;
  }

  setPokemonDetail(int index, Pokemon pokemonDetail) {
    _pokemonsDetailMap[index] = pokemonDetail;
  }

  getPokemons() async {
    _isLoading = true;
    notifyListeners();

    var response = await PokemonService.getPokemons();
    if (response is Success) {
      var data = response.response as Map<String, dynamic>;
      var pokemonResponse = PokemonsModel.fromJson(data);

      _nextUrl = pokemonResponse.next.toString();
      setPokemonListModel(pokemonResponse.results);

      // Load details asynchronously without blocking UI
      _loadPokemonDetailsAsync();
    } else {
      debugPrint('ocurrió un error');
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

  getMorePokemons() async {
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

  getPokemonDetails({required int index, required String name}) async {
    var response = await PokemonService.getPokemonsDetail(name: name);

    if (response is Success) {
      var data1 = response.response as Map<String, dynamic>;
      var detailResponse = PokemonDetailModel.fromJson(data1);

      setCardListModel(index, CardModel.fromJson(data1));
      var secResponse =
          await PokemonService.getSpeciesDetails(detailResponse.id!);
      var data2 = secResponse.response as Map<String, dynamic>;
      if (secResponse is Success) {
        pokemon = Pokemon.fromJson(data1, data2);
        setPokemonDetail(index, pokemon);
      }
    }
    return pokemon;
  }

  // Separate method for search functionality
  Future<Pokemon?> searchPokemonByName({required String name}) async {
    var response = await PokemonService.getPokemonsDetail(name: name);

    if (response is Success) {
      var data1 = response.response as Map<String, dynamic>;
      var detailResponse = PokemonDetailModel.fromJson(data1);

      var secResponse =
          await PokemonService.getSpeciesDetails(detailResponse.id!);
      var data2 = secResponse.response as Map<String, dynamic>;
      if (secResponse is Success) {
        return Pokemon.fromJson(data1, data2);
      }
    }
    return null;
  }
}
