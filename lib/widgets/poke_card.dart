import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poke_app/models/card_model.dart';
import 'package:poke_app/models/pokemon.dart';
import 'package:poke_app/view/poke_detail_screen.dart';
import 'package:poke_app/view/pokemon_screen.dart';
import 'package:poke_app/widgets/type_card.dart';

import '../helpers/map_cardColor.dart';
import '../models/pokemons_detail_model.dart';

class PokeCard extends StatelessWidget {
  CardModel poke;
  Pokemon? pokeDetail;
  final BuildContext context;

  PokeCard(this.poke, this.pokeDetail, this.context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                // builder: (context) => PokemonScreen(pokemon: pokeDetail)
                builder: (context) => PokeDetailScreen(
                      pokemon: pokeDetail,
                    )));
        //Navigator.of(context).pushNamed(PokemonScreen.routeName);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
        margin: const EdgeInsets.only(bottom: 20, top: 5, left: 5, right: 5),
        decoration: BoxDecoration(
          color: setCardColor(poke.type1.toString()),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: setCardColor(poke.type1.toString()).withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#' + poke.id.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w800),
                ),
                Text(
                  poke.name.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    if (poke.type1 != null) TypeCard(poke.type1),
                    const SizedBox(width: 5),
                    if (poke.type2 != null) TypeCard(poke.type2),
                  ],
                )
              ],
            ),
            Positioned(
              right: -35,
              bottom: -50,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/pokeLoad.gif',
                image: poke.sprite,
                imageScale: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
