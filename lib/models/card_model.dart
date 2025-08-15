import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CardModel with ChangeNotifier {
  String? id;
  String? name;
  Map<String, dynamic>? sprites;
  List<Map<String, dynamic>>? types;

  CardModel({
    this.id,
    this.name,
    this.sprites,
    this.types,
  });

  // Computed properties for easy access to commonly used values
  String? get sprite => sprites?['front_default'];

  String? get type1 {
    if (types != null && types!.isNotEmpty) {
      return types![0]['type']?['name'];
    }
    return null;
  }

  String? get type2 {
    if (types != null && types!.length > 1) {
      return types![1]['type']?['name'];
    }
    return null;
  }

  /// Single factory constructor that handles the API structure
  /// This same structure is used for both API responses and caching
  factory CardModel.fromJson(Map<String, dynamic> json) {
    try {
      return CardModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? 'Unknown',
        sprites: json['sprites'] as Map<String, dynamic>?,
        types: (json['types'] as List?)?.cast<Map<String, dynamic>>(),
      );
    } catch (e) {
      debugPrint('Error parsing JSON for CardModel: $e');
      // Fallback with default normal type
      return CardModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? 'Unknown',
        sprites: null,
        types: [
          {
            'type': {'name': 'normal'}
          }
        ],
      );
    }
  }

  /// Serialize to JSON - maintains the same API structure
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sprites': sprites,
      'types': types,
    };
  }
}
