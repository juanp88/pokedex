import 'package:flutter/material.dart';
import '../helpers/map_cardColor.dart';
import '../models/pokemon.dart';

class TabButton extends StatelessWidget {
  final Pokemon pokeData;
  final String title;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  const TabButton({
    super.key,
    required this.pokeData,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isSelected ? setTypeColor(pokeData.type1) : Colors.transparent,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color:
                      isSelected ? Colors.white : setTypeColor(pokeData.type1),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
