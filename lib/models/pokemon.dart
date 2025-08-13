import 'package:flutter/material.dart';

class Pokemon with ChangeNotifier {
  var id;
  var name;
  Sprites? sprites;
  var type1;
  var type2;
  var hp;
  var attack;
  var defense;
  var speed;
  var spAttack;
  var spDefense;
  var description;
  var height;
  var weight;
  var species;
  var ability1;
  var ability2;
  var ability3;
  var moves;

  Pokemon({
    this.id,
    this.name,
    this.sprites,
    this.type1,
    this.type2,
    this.hp,
    this.attack,
    this.defense,
    this.speed,
    this.spAttack,
    this.spDefense,
    this.description,
    this.height,
    this.weight,
    this.species,
    this.ability1,
    this.ability2,
    this.ability3,
    this.moves,
  });

  factory Pokemon.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> secJson) {
    String pokeId = json['id'].toString();
    int hp = json['stats'][0]['base_stat'];
    int attack = json['stats'][1]['base_stat'];
    int defense = json['stats'][2]['base_stat'];
    int spAttack = json['stats'][3]['base_stat'];
    int spDefense = json['stats'][4]['base_stat'];
    int speed = json['stats'][5]['base_stat'];
    // need to find more effective way to access flavor text
    List descList = secJson['flavor_text_entries'];
    int? descIndex;
    for (int i = 0; i < descList.length; i++) {
      var desc = secJson['flavor_text_entries'][i]['language']['name'];
      if (desc == 'en') {
        descIndex = i;
      }
    }
    String pokeDesc = secJson['flavor_text_entries'][descIndex]['flavor_text'];
    String pokeSpec = secJson['genera'][7]['genus'];
    double pokeHp = hp / 100;
    double pokeAttack = attack / 100;
    double pokeDef = defense / 100;
    double pokeSpAttack = spAttack / 100;
    double pokespDefense = spDefense / 100;
    double pokeSpeed = speed / 100;
    List abilities = json['abilities'];
    List types = json['types'];

    List movesList = json['moves'];
    List tempMovesList = [];
    for (int i = 0; i < movesList.length; i++) {
      var moves = json['moves'][i]['move']['name'];
      tempMovesList.add(moves);
    }

    return Pokemon(
      id: pokeId,
      name: json['name'],
      sprites: Sprites.fromJson(json['sprites']),
      type1: json['types'][0]['type']['name'],
      type2: types.length == 2 ? json['types'][1]['type']['name'] : null,
      hp: pokeHp,
      attack: pokeAttack,
      defense: pokeDef,
      speed: pokeSpeed,
      spAttack: pokeSpAttack,
      spDefense: pokespDefense,
      description: pokeDesc,
      height: json['height'],
      weight: json['weight'],
      species: pokeSpec,
      ability1: json['abilities'][0]['ability']['name'],
      ability2:
          abilities.length >= 2 ? json['abilities'][1]['ability']['name'] : '',
      ability3:
          abilities.length >= 3 ? json['abilities'][2]['ability']['name'] : '',
      moves: tempMovesList,
    );
  }

  // Add caching support methods
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sprites': sprites?.toJson(),
      'type1': type1,
      'type2': type2,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'speed': speed,
      'spAttack': spAttack,
      'spDefense': spDefense,
      'description': description,
      'height': height,
      'weight': weight,
      'species': species,
      'ability1': ability1,
      'ability2': ability2,
      'ability3': ability3,
      'moves': moves,
    };
  }

  factory Pokemon.fromCachedJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      sprites:
          json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null,
      type1: json['type1'],
      type2: json['type2'],
      hp: json['hp'],
      attack: json['attack'],
      defense: json['defense'],
      speed: json['speed'],
      spAttack: json['spAttack'],
      spDefense: json['spDefense'],
      description: json['description'],
      height: json['height'],
      weight: json['weight'],
      species: json['species'],
      ability1: json['ability1'],
      ability2: json['ability2'],
      ability3: json['ability3'],
      moves: json['moves'],
    );
  }
}

class Sprites {
  String? backDefault;
  String? backFemale;
  String? backShiny;
  String? backShinyFemale;
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;
  Other? other;

  Sprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.other,
  });

  Sprites.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backFemale = json['back_female'];
    backShiny = json['back_shiny'];
    backShinyFemale = json['back_shiny_female'];
    frontDefault = json['front_default'];
    frontFemale = json['front_female'];
    frontShiny = json['front_shiny'];
    frontShinyFemale = json['front_shiny_female'];
    other = json['other'] != null ? Other.fromJson(json['other']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['back_default'] = backDefault;
    data['back_female'] = backFemale;
    data['back_shiny'] = backShiny;
    data['back_shiny_female'] = backShinyFemale;
    data['front_default'] = frontDefault;
    data['front_female'] = frontFemale;
    data['front_shiny'] = frontShiny;
    data['front_shiny_female'] = frontShinyFemale;
    if (other != null) {
      data['other'] = other!.toJson();
    }
    return data;
  }
}

class Other {
  DreamWorld? dreamWorld;
  Home? home;
  OfficialArtwork? officialArtwork;

  Other({this.dreamWorld, this.home, this.officialArtwork});

  Other.fromJson(Map<String, dynamic> json) {
    dreamWorld = json['dream_world'] != null
        ? DreamWorld.fromJson(json['dream_world'])
        : null;
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
    officialArtwork = json['official-artwork'] != null
        ? OfficialArtwork.fromJson(json['official-artwork'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dreamWorld != null) {
      data['dream_world'] = dreamWorld!.toJson();
    }
    if (home != null) {
      data['home'] = home!.toJson();
    }
    if (officialArtwork != null) {
      data['official-artwork'] = officialArtwork!.toJson();
    }
    return data;
  }
}

class DreamWorld {
  String? frontDefault;
  Null frontFemale;

  DreamWorld({this.frontDefault, this.frontFemale});

  DreamWorld.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
    frontFemale = json['front_female'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['front_default'] = frontDefault;
    data['front_female'] = frontFemale;
    return data;
  }
}

class Home {
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;

  Home(
      {this.frontDefault,
      this.frontFemale,
      this.frontShiny,
      this.frontShinyFemale});

  Home.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
    frontFemale = json['front_female'];
    frontShiny = json['front_shiny'];
    frontShinyFemale = json['front_shiny_female'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['front_default'] = frontDefault;
    data['front_female'] = frontFemale;
    data['front_shiny'] = frontShiny;
    data['front_shiny_female'] = frontShinyFemale;
    return data;
  }
}

class OfficialArtwork {
  String? frontDefault;

  OfficialArtwork({this.frontDefault});

  OfficialArtwork.fromJson(Map<String, dynamic> json) {
    frontDefault = json['front_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['front_default'] = frontDefault;
    return data;
  }
}
