import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app/models/pokemon_model.dart';
import 'package:poke_app/utils/api_status.dart';
import 'package:poke_app/utils/config.dart';

import '../models/pokemons_detail_model.dart';

class PokemonService {
  // Simple cache to avoid repeated API calls
  static final Map<String, dynamic> _cache = {};

  static Future<Object> getPokemons() async {
    try {
      final response = await http.get(Uri.parse(config.firstPage),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return Success(response: json.decode(response.body));
      } else {
        return Failure(code: 100, errorResponse: 'Invalid Response');
      }
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No internet');
    } catch (e) {
      debugPrint(e.toString());
      return Failure(code: 103, errorResponse: 'Unknow error');
    }
  }

  static Future<Object> getMorePokemons(String url) async {
    try {
      debugPrint("Getting more Pokemons");
      final response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        var pokemonResponse =
            PokemonsModel.fromJson(json.decode(response.body));
        return Success(response: pokemonResponse);
      } else {
        return Failure(code: 100, errorResponse: 'Invalid Response');
      }
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No internet');
    } catch (e) {
      debugPrint(e.toString());
      return Failure(code: 103, errorResponse: 'Unknow error');
    }
  }

  static Future<dynamic> getPokemonsDetail({required String name}) async {
    // Check cache first
    if (_cache.containsKey('pokemon_$name')) {
      return Success(response: _cache['pokemon_$name']);
    }

    try {
      Uri url = Uri.parse(config.baseURL + name);
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _cache['pokemon_$name'] = data; // Cache the result
        return Success(response: data);
      } else {
        return Failure(code: 100, errorResponse: 'Invalid Response');
      }
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No internet');
    } catch (e) {
      debugPrint(e.toString());
      return Failure(code: 103, errorResponse: 'Unknow error');
    }
  }

  static Future<dynamic> getSpeciesDetails(int id) async {
    // Check cache first
    if (_cache.containsKey('species_$id')) {
      return Success(response: _cache['species_$id']);
    }

    try {
      Uri url = Uri.parse('${config.speciesUrl}$id');
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _cache['species_$id'] = data; // Cache the result
        return Success(response: data);
      } else {
        return Failure(code: 100, errorResponse: 'Invalid Response');
      }
    } on HttpException {
      return Failure(code: 101, errorResponse: 'No internet');
    } catch (e) {
      debugPrint(e.toString());
      return Failure(code: 103, errorResponse: 'Unknow error');
    }
  }
}
