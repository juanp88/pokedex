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
  var _pokemonListModel = [];
  var _nextUrl = '';
  List<CardModel> _pokeList = [];
  Pokemon pokemon = Pokemon();

  bool get isLoading => _isLoading;
  get pokemonListModel => _pokemonListModel;
  get pokeList => _pokeList;

  final List<Pokemon> _pokemonsDetail = [];
  List<Pokemon> get pokemonsDetail => _pokemonsDetail;

  PokemonViewModel() {
    getPokemons();
  }

  setPokemonListModel(pokemonListModel) {
    _pokemonListModel = pokemonListModel;
  }

  setCardListModel(pokemonDetail) {
    _pokeList.add(pokemonDetail);
  }

  getPokemons() async {
    _isLoading = true;
    var response = await PokemonService.getPokemons();
    if (response is Success) {
      var data = response.response as Map<String, dynamic>;

      var pokemonResponse = PokemonsModel.fromJson(data);

      _nextUrl = pokemonResponse.next.toString();
      setPokemonListModel(pokemonResponse.results);

      for (var result in pokemonListModel) {
        await getPokemonDetails(name: result.name!);
      }
    } else {
      debugPrint('ocurrió un error');
    }
    _isLoading = false;
    notifyListeners();
  }

  getMorePokemons() async {
    _isLoading = true;
    notifyListeners();
    String url = _nextUrl;
    if (pokemonListModel.length > 0) {
      var response = await PokemonService.getMorePokemons(url);
      if (response is Success) {
        var list = response.response as PokemonsModel;
        _nextUrl = list.next.toString();
        for (var result in list.results!) {
          await getPokemonDetails(name: result.name!);
        }
        _pokemonListModel.addAll(list.results as Iterable);
        _isLoading = false;

        notifyListeners();
      }
    }
  }

  getPokemonDetails({required String name}) async {
    var response = await PokemonService.getPokemonsDetail(name: name);

    if (response is Success) {
      var data1 = response.response as Map<String, dynamic>;
      var detailResponse = PokemonDetailModel.fromJson(data1);

      setCardListModel(CardModel.fromJson(data1));
      var secResponse =
          await PokemonService.getSpeciesDetails(detailResponse.id!);
      var data2 = secResponse.response as Map<String, dynamic>;
      if (secResponse is Success) {
        pokemon = Pokemon.fromJson(data1, data2);
        _pokemonsDetail.add(pokemon);
      }
    }
    return pokemon;
  }
}
