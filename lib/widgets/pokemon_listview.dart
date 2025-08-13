import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:poke_app/models/card_model.dart';
import 'package:poke_app/models/pokemon.dart';
import 'package:poke_app/view_model/pokemon_view_model.dart';
import 'package:poke_app/widgets/poke_card.dart';

import '../models/pokemon_model.dart';

class PokemonListView extends StatelessWidget {
  final PokemonViewModel pokemonViewModel;
  final ScrollController scrollController;

  const PokemonListView({
    super.key,
    required this.pokemonViewModel,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            key: const PageStorageKey("Pokemon List"),
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Result pokemon = pokemonViewModel.pokemonListModel[index];

              // Check if details are loaded for this specific index
              if (!pokemonViewModel.hasDataAtIndex(index)) {
                // Show loading placeholder while details are being fetched
                return Container(
                  height: 120,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blue[400]!),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pokemon.name?.toUpperCase() ??
                              AppLocalizations.of(context)!.loading,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Get data from the maps using index
              final pokemonCards = pokemonViewModel.pokeList;
              final pokemonDetails = pokemonViewModel.pokemonsDetail;

              // Find the correct data for this index
              CardModel? pokemonCard;
              Pokemon? pokemonDetail;

              for (int i = 0; i < pokemonCards.length; i++) {
                if (pokemonCards[i].name?.toLowerCase() ==
                    pokemon.name?.toLowerCase()) {
                  pokemonCard = pokemonCards[i];
                  break;
                }
              }

              for (int i = 0; i < pokemonDetails.length; i++) {
                if (pokemonDetails[i].name?.toLowerCase() ==
                    pokemon.name?.toLowerCase()) {
                  pokemonDetail = pokemonDetails[i];
                  break;
                }
              }

              if (pokemonCard != null && pokemonDetail != null) {
                return PokeCard(pokemonCard, pokemonDetail, context);
              }

              // Fallback loading state
              return Container(
                height: 120,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    pokemon.name?.toUpperCase() ??
                        AppLocalizations.of(context)!.loading,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: pokemonViewModel.pokemonListModel.length,
          ),
        ),
        // Bottom loading indicator for pagination
        if (pokemonViewModel.isLoadingMore)
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.loadingMorePokemon,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
