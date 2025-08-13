import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_app/models/card_model.dart';
import 'package:poke_app/models/pokemon.dart';
import 'package:poke_app/view/poke_detail_screen.dart';
import 'package:poke_app/widgets/type_card.dart';

import '../helpers/map_cardColor.dart';

class PokeCard extends StatelessWidget {
  final CardModel poke;
  final Pokemon? pokeDetail;
  final BuildContext context;

  const PokeCard(this.poke, this.pokeDetail, this.context, {super.key});

  Widget _buildPokemonImage(String? imageUrl) {
    debugPrint('PokeCard: Building image for ${poke.name} with URL: $imageUrl');

    String? finalImageUrl = imageUrl;

    // If no sprite URL, try to construct one from Pokemon ID
    if (finalImageUrl == null || finalImageUrl.isEmpty) {
      if (poke.id != null && poke.id.toString().isNotEmpty) {
        finalImageUrl =
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${poke.id}.png';
        debugPrint(
            'PokeCard: Constructed fallback URL for ${poke.name}: $finalImageUrl');
      }
    }

    // Check if we have a valid image URL
    if (finalImageUrl == null ||
        finalImageUrl.isEmpty ||
        !Uri.tryParse(finalImageUrl)!.hasAbsolutePath) {
      debugPrint('PokeCard: Invalid URL for ${poke.name}, showing placeholder');
      return Image.asset(
        'assets/images/pokeLoad.gif',
        scale: 0.5,
      );
    }

    return CachedNetworkImage(
      imageUrl: finalImageUrl,
      placeholder: (context, url) => Image.asset(
        'assets/images/pokeLoad.gif',
        scale: 0.5,
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/pokeLoad.gif',
        scale: 0.5,
      ),
      scale: 0.5,
      fadeInDuration: const Duration(milliseconds: 300),
    );
  }

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
              color: setCardColor(poke.type1.toString()).withValues(alpha: 0.5),
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
                  '#${poke.id}',
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
              child: _buildPokemonImage(poke.sprite),
            ),
          ],
        ),
      ),
    );
  }
}
