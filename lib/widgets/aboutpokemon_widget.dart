import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:poke_app/helpers/map_cardColor.dart';
import 'package:poke_app/models/pokemon.dart';

class AboutPokemonWidget extends StatelessWidget {
  final Pokemon? pokemon;
  const AboutPokemonWidget({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.height),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.weight),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.abilities),
          ],
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${pokemon!.height! / 10} cm',
              ),
              const SizedBox(height: 20),
              Text(
                '${pokemon!.weight! / 10} kg',
              ),
              const SizedBox(height: 20),
              Wrap(
                children: [
                  _abilities(pokemon!.ability1),
                  _abilities(pokemon!.ability2),
                  _abilities(pokemon!.ability3),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _abilities(ability) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
        bottom: 10,
      ),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: setTypeColor(
          pokemon!.type1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        ability,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
