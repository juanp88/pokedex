import 'package:flutter/material.dart';
import 'package:poke_app/view/home.dart';

Map<String, WidgetBuilder> generateRoutes() {
  return {
    'home': (BuildContext context) => HomePage(),
    // 'pokemon': (BuildContext context) => PokemonScreen(),
  };
}
