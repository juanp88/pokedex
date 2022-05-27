import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/map_cardColor.dart';
import '../helpers/map_typeIcon.dart';

class TypeCard extends StatelessWidget {
  final String type;
  TypeCard(this.type);
  @override
  Widget build(BuildContext context) {
    String typeIcon = setTypeIcon(type);
    String? typeText = toBeginningOfSentenceCase(type);
    return Material(
      elevation: 2,
      shadowColor: setTypeColor(type),
      borderRadius: BorderRadius.circular(3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: setTypeColor(type),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              typeIcon,
              style: const TextStyle(
                fontFamily: 'PokeGoTypes',
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              typeText!,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.5, 2),
                    blurRadius: 3.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
