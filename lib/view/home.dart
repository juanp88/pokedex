import 'package:flutter/material.dart';
import 'package:poke_app/models/pokemon_model.dart';
import 'package:poke_app/view_model/pokemon_view_model.dart';
import 'package:poke_app/widgets/home_header.dart';
import 'package:poke_app/widgets/pokemon_listview.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<PokemonViewModel>().getMorePokemons();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonViewModel =
        Provider.of<PokemonViewModel>(context, listen: true);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                homeHeader(),
                pokemonViewModel.isLoading == true
                    ? Expanded(
                        flex: 3,
                        child: Center(
                          child: Image.asset('assets/images/pokeLoad.gif'),
                        ),
                      )
                    : Expanded(
                        flex: 4,
                        child: PokemonListView(
                            pokemonViewModel, _scrollController),
                        // child: Placeholder(
                        //   color: Colors.amberAccent,
                        // ),
                      )
              ],
            )));
  }
}
