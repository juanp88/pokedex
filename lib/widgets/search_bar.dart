import 'package:flutter/material.dart';
import 'package:poke_app/models/pokemon.dart';
import 'package:poke_app/view/pokemon_screen.dart';
import 'package:provider/provider.dart';

import '../view_model/pokemon_view_model.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<PokemonViewModel>(context);
    return Container(
      margin: const EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        maxLines: 1,
        controller: _textController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey[600]),
          errorText: _validate ? null : null,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          icon: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          hintText: "What Pokémon are you looking for? ",
        ),
        onSubmitted: (value) async {
          if (value.isNotEmpty) {
            Pokemon? pokemon = await providerData.searchPokemonByName(
                name: value.toLowerCase());

            if (pokemon != null) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return ScaleTransition(
                      alignment: Alignment.center,
                      scale: Tween<double>(begin: 0.1, end: 1).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutQuart,
                        ),
                      ),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return PokemonScreen(pokemon: pokemon);
                  },
                ),
              );
            } else {
              // Show error message if Pokemon not found
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pokémon "$value" not found!'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }

  // Removed unused _getPokemon method
}
