import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_app/widgets/pokeball_sprite_widget.dart';
import '../l10n/app_localizations.dart';

import 'package:poke_app/models/pokemon.dart';
import 'package:poke_app/view_model/pokemon_view_model.dart';
import 'package:provider/provider.dart';
import '../widgets/tab_button.dart';

import '../helpers/map_cardColor.dart';
import '../widgets/poke_about.dart';
import '../widgets/poke_moves.dart';
import '../widgets/poke_stats.dart';
import '../widgets/type_card.dart';

class PokeDetailScreen extends StatefulWidget {
  final Pokemon? pokemon;
  const PokeDetailScreen({super.key, required this.pokemon});

  @override
  _PokeDetailScreenState createState() => _PokeDetailScreenState();
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {
  int _selectedIndex = 0;

  Widget _buildPokemonImage() {
    // Get the image URL safely
    String? imageUrl;
    try {
      imageUrl = widget.pokemon?.sprites?.other?.officialArtwork?.frontDefault;
    } catch (e) {
      imageUrl = null;
    }

    // Check if we have a valid image URL
    if (imageUrl == null ||
        imageUrl.isEmpty ||
        !Uri.tryParse(imageUrl)!.hasAbsolutePath) {
      return const Center(
        child: PokeballSpriteWidget(
          size: 120,
          animationSpeed: 0.3,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(
        child: PokeballSpriteWidget(
          size: 120,
          animationSpeed: 0.3,
        ),
      ),
      errorWidget: (context, url, error) => const Center(
        child: PokeballSpriteWidget(
          size: 120,
          animationSpeed: 0.3,
        ),
      ),
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<PokemonViewModel>(context);

    return Scaffold(
        backgroundColor: providerData.isLoading
            ? Colors.white
            : providerData.isLoading
                ? Colors.white
                : setCardColor(widget.pokemon!.type1),
        body: providerData.isLoading
            ? const Center(
                child: PokeballSpriteWidget(
                size: 50,
                animationSpeed: 0.5,
              ))
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 2,
                    color: providerData.isLoading
                        ? Colors.white
                        : setCardColor(widget.pokemon!.type1),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
// Pokemon image
                      Positioned(
                        right: 35,
                        bottom: MediaQuery.of(context).size.height * 0.006,
                        left: 35,
                        child: SizedBox(
                          height: 200,
                          child: _buildPokemonImage(),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(top: 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Pokemon name
                          Text(
                            widget.pokemon!.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35,
                            ),
                          ),
                          // Pokemon ID
                          Text(
                            '#${widget.pokemon!.id}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.pokemon!.type1 != null)
                                TypeCard(widget.pokemon!.type1),
                              if (widget.pokemon!.type2 != null)
                                const SizedBox(width: 10),
                              if (widget.pokemon!.type2 != null)
                                TypeCard(widget.pokemon!.type2),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 25,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                              child: Text(
                                widget.pokemon!.description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 2,
                                child: TabButton(
                                  pokeData: widget.pokemon!,
                                  title: AppLocalizations.of(context)!
                                      .about
                                      .toUpperCase(),
                                  index: 0,
                                  selectedIndex: _selectedIndex,
                                  onTap: () =>
                                      setState(() => _selectedIndex = 0),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                flex: 3,
                                child: TabButton(
                                  pokeData: widget.pokemon!,
                                  title: AppLocalizations.of(context)!
                                      .stats
                                      .toUpperCase(),
                                  index: 1,
                                  selectedIndex: _selectedIndex,
                                  onTap: () =>
                                      setState(() => _selectedIndex = 1),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                flex: 2,
                                child: TabButton(
                                  pokeData: widget.pokemon!,
                                  title: AppLocalizations.of(context)!
                                      .moves
                                      .toUpperCase(),
                                  index: 2,
                                  selectedIndex: _selectedIndex,
                                  onTap: () =>
                                      setState(() => _selectedIndex = 2),
                                ),
                              ),
                            ],
                          ),
                          _selectedIndex == 0
                              ? Expanded(
                                  child: PokeAbout(widget.pokemon!),
                                )
                              : _selectedIndex == 1
                                  ? PokeStats(widget.pokemon!)
                                  : Expanded(
                                      child: PokeMoves(widget.pokemon!),
                                    )
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }
}
