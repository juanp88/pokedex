import 'package:flutter/material.dart';
import 'package:poke_app/routes.dart';
import 'package:poke_app/view_model/pokemon_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonViewModel(),
        )
      ],
      child: MaterialApp(
        title: 'PokeApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'home',
        routes: generateRoutes(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
