import 'package:flutter/material.dart';
import '../view/cache_management_screen.dart';

Widget homeHeader(BuildContext context) {
  return Expanded(
    flex: 2,
    child: Container(
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Colors.red,
        image: DecorationImage(
            opacity: 0.2,
            image: AssetImage("assets/images/PokeballShadow3.png"),
            fit: BoxFit.scaleDown),
      ),
      child: Column(
        children: [
          // Cache management button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.storage,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CacheManagementScreen(),
                    ),
                  );
                },
                tooltip: 'Cache Management',
              ),
            ],
          ),
          // Title
          const Expanded(
            flex: 2,
            child: SizedBox(
              width: 500,
              child: Center(
                child: Text(
                  "Pokedex",
                  style: TextStyle(
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Color.fromARGB(255, 255, 192, 2)),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
