import 'package:flutter/material.dart';

import '../helpers/map_cardColor.dart';
import '../models/pokemon.dart';

class PokeStats extends StatelessWidget {
  final Pokemon pokeData;

  const PokeStats(this.pokeData, {super.key});

  String convertValue(double value) {
    double initValue = value * 100;
    return initValue.toStringAsFixed(0);
  }

  Widget statsBar(String label, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Fixed width for label to ensure alignment
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: setTypeColor(pokeData.type1),
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Fixed width for value to ensure alignment
          SizedBox(
            width: 35,
            child: Text(
              convertValue(value),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: setTypeColor(pokeData.type1),
                fontSize: 12,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(width: 12),
          // Flexible progress bar that adapts to available space
          Expanded(
            child: SizedBox(
              height: 8,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      setCardColor(pokeData.type1)),
                  value: value,
                ),
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
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Column(
        children: [
          const SizedBox(height: 15),
          statsBar('HP', pokeData.hp),
          statsBar('ATK', pokeData.attack),
          statsBar('DEF', pokeData.defense),
          statsBar('SATK', pokeData.spAttack),
          statsBar('SDEF', pokeData.spDefense),
          statsBar('SPD', pokeData.speed),
        ],
      ),
    );
  }
}
