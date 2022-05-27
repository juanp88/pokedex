import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poke_app/widgets/search_bar.dart';

//falta implementar función de busqueda.

Widget homeHeader() {
  return Expanded(
    flex: 2,
    child: Container(
      padding: const EdgeInsets.all(40),
      child: Column(children: const [
        Expanded(
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
            )),
        //Expanded(flex: 2, child: SearchBar())
      ]),

      //color: Colors.red,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Colors.red,
        image: DecorationImage(
            opacity: 0.2,
            image: AssetImage("assets/images/PokeballShadow3.png"),
            fit: BoxFit.scaleDown),
      ),
    ),
  );
}
