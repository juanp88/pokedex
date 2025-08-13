import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/pokemon.dart';
import '../helpers/map_cardColor.dart';

class PokeAbout extends StatelessWidget {
  final Pokemon pokeData;

  const PokeAbout(this.pokeData, {super.key});

  String convertValue(dynamic value) {
    double convertedValue = value / 10;
    return convertedValue.toString();
  }

  Widget rowBuilder(String text, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pokedex Data',
            style: TextStyle(
              color: setTypeColor(pokeData.type1),
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                rowBuilder('Species', pokeData.species),
                rowBuilder('Height', '${convertValue(pokeData.height)} m'),
                rowBuilder('Weight', '${convertValue(pokeData.weight)} kg'),
                rowBuilder(
                  'Abilities',
                  '${toBeginningOfSentenceCase<String?>(pokeData.ability1)!}\n${toBeginningOfSentenceCase<String?>(pokeData.ability2)!}\n${toBeginningOfSentenceCase<String?>(pokeData.ability3)!}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
