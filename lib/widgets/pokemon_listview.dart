import 'package:flutter/cupertino.dart';
import 'package:poke_app/models/card_model.dart';
import 'package:poke_app/models/pokemon.dart';
import 'package:poke_app/models/pokemons_detail_model.dart';
import 'package:poke_app/view_model/pokemon_view_model.dart';
import 'package:poke_app/widgets/poke_card.dart';

import '../models/pokemon_model.dart';

Widget PokemonListView(
    PokemonViewModel pokemonViewModel, ScrollController scrollController) {
  return ListView.separated(
      key: const PageStorageKey("Pokemon LIst"),
      controller: scrollController,
      itemBuilder: (context, index) {
        Result pokemon = pokemonViewModel.pokemonListModel[index];
        Pokemon pokemonDetail = pokemonViewModel.pokemonsDetail[index];
        CardModel pokemonCard = pokemonViewModel.pokeList[index];

        return PokeCard(pokemonCard, pokemonDetail, context);

        // return Row(
        //   children: [
        //     Expanded(
        //         child: Container(
        //             height: 20, child: Text(pokemon.name.toString()))),
        //     Text(pokemonDetail.types![0].type!.name.toString())
        //   ],
        // );
      },
      separatorBuilder: (context, index) => Container(
            height: 5,
          ),
      itemCount: pokemonViewModel.pokemonListModel.length);
}
