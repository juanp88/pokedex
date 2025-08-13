import 'package:flutter/material.dart';
import 'package:poke_app/view/home.dart';
import 'package:poke_app/view/cache_management_screen.dart';

Map<String, WidgetBuilder> generateRoutes() {
  return {
    'home': (BuildContext context) => HomePage(),
    'cache_management': (BuildContext context) => const CacheManagementScreen(),
    // 'pokemon': (BuildContext context) => PokemonScreen(),
  };
}
