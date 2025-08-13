import 'package:flutter/material.dart';
import 'package:poke_app/view_model/pokemon_view_model.dart';
import 'package:poke_app/widgets/home_header.dart';
import 'package:poke_app/widgets/pokemon_listview.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // Trigger loading when user is near the bottom (200px before end)
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
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
                homeHeader(context),
                // Cache indicator
                if (pokemonViewModel.isUsingCache)
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    color: Colors.orange.withValues(alpha: 0.1),
                    child: Column(
                      children: [
                        Text(
                          'Offline mode',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.offline_bolt,
                              size: 16,
                              color: Colors.orange[700],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Using cached data',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                pokemonViewModel.isLoading == true
                    ? Expanded(
                        flex: 3,
                        child: Center(
                          child: Image.asset('assets/images/pokeLoad.gif'),
                        ),
                      )
                    : pokemonViewModel.isOffline
                        ? Expanded(
                            flex: 3,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.wifi_off,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'No Internet Connection',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'No cached Pokemon data available.\nConnect to the internet to load Pokemon.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      pokemonViewModel.resetOfflineState();
                                      pokemonViewModel.getPokemons();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            flex: 4,
                            child: pokemonListView(
                                pokemonViewModel, _scrollController),
                          )
              ],
            )));
  }
}
