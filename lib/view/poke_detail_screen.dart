import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:poke_app/models/pokemon.dart';
import 'package:poke_app/models/pokemons_detail_model.dart';
import 'package:poke_app/view_model/pokemon_view_model.dart';
import 'package:provider/provider.dart';

import '../helpers/map_cardColor.dart';
import '../widgets/poke_about.dart';
import '../widgets/poke_moves.dart';
import '../widgets/poke_stats.dart';
import '../widgets/type_card.dart';

class PokeDetailScreen extends StatefulWidget {
  final Pokemon? pokemon;
  const PokeDetailScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  _PokeDetailScreenState createState() => _PokeDetailScreenState();
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<PokemonViewModel>(context);

    return Scaffold(
        backgroundColor: providerData.isLoading
            ? Colors.white
            : providerData.isLoading
                ? Colors.white
                : setCardColor(widget.pokemon!.type1),
        body: providerData.isLoading
            ? Center(child: Image.asset('assets/images/pokeLoad.gif'))
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 2,
                    color: providerData.isLoading
                        ? Colors.white
                        : setCardColor(widget.pokemon!.type1),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
// Pokemon image
                      Positioned(
                        right: 35,
                        bottom: MediaQuery.of(context).size.height * 0.006,
                        left: 35,
                        child: SizedBox(
                          height: 200,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/pokeLoad.gif',
                            image: widget.pokemon!.sprites!.other!
                                .officialArtwork!.frontDefault
                                .toString(),
                            //imageScale: 0.15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Pokemon name
                          Text(
                            widget.pokemon!.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35,
                            ),
                          ),
                          // Pokemon ID
                          Text(
                            '#' + widget.pokemon!.id.toString(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.pokemon!.type1 != null)
                                TypeCard(widget.pokemon!.type1),
                              if (widget.pokemon!.type2 != null)
                                const SizedBox(width: 10),
                              if (widget.pokemon!.type2 != null)
                                TypeCard(widget.pokemon!.type2),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 25,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                              child: Text(
                                widget.pokemon!.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buttonBuilder(widget.pokemon!, 'ABOUT', 0),
                              _buttonBuilder(widget.pokemon!, 'STATS', 1),
                              _buttonBuilder(widget.pokemon!, 'MOVES', 2),
                            ],
                          ),
                          _selectedIndex == 0
                              ? Expanded(
                                  child: PokeAbout(widget.pokemon!),
                                )
                              : _selectedIndex == 1
                                  ? PokeStats(widget.pokemon!)
                                  : Expanded(
                                      child: PokeMoves(widget.pokemon!),
                                    )
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }

  Widget _buttonBuilder(Pokemon pokeData, String title, int myIndex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = myIndex;
        });
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _selectedIndex == myIndex
              ? setTypeColor(pokeData.type1)
              : Colors.transparent,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: _selectedIndex == myIndex
                    ? Colors.white
                    : setTypeColor(pokeData.type1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
