import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CardModel with ChangeNotifier {
  var id;
  var name;
  var sprite;
  var type1;
  var type2;

  CardModel({
    this.id,
    this.name,
    this.sprite,
    this.type1,
    this.type2,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    try {
      String pokeId = json['id']?.toString() ?? '';

      // Handle sprites safely
      String? sprite;
      if (json['sprites'] != null && json['sprites'] is Map) {
        sprite = json['sprites']['front_default'];
        debugPrint('CardModel: Loading sprite for ${json['name']}: $sprite');
      } else {
        debugPrint('CardModel: No sprites data for ${json['name']}');
      }

      // Handle types safely
      String? type1;
      String? type2;

      if (json['types'] != null && json['types'] is List) {
        final List types = json['types'] as List;
        if (types.isNotEmpty && types[0] != null && types[0]['type'] != null) {
          type1 = types[0]['type']['name'];
        }
        if (types.length > 1 && types[1] != null && types[1]['type'] != null) {
          type2 = types[1]['type']['name'];
        }
      }

      return CardModel(
        id: pokeId,
        name: json['name'],
        sprite: sprite,
        type1: type1,
        type2: type2,
      );
    } catch (e) {
      // Fallback for corrupted cache data
      return CardModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? 'Unknown',
        sprite: null,
        type1: 'normal',
        type2: null,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sprite': sprite,
      'type1': type1,
      'type2': type2,
    };
  }
}
