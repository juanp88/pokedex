import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../l10n/app_localizations.dart';
import 'package:poke_app/helpers/map_cardColor.dart';
import 'package:poke_app/models/pokemon.dart';
import 'package:poke_app/widgets/pokeball_sprite_widget.dart';
import '../widgets/aboutpokemon_widget.dart';

class PokemonScreen extends StatefulWidget {
  final Pokemon? pokemon;
  const PokemonScreen({super.key, required this.pokemon});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen>
    with TickerProviderStateMixin {
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

  TabController? _tabController;

  void init(TickerProvider tickerProvider) {
    _tabController = TabController(length: 2, vsync: tickerProvider);
  }

  @override
  void initState() {
    super.initState();
    init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: const TextStyle(color: Colors.yellow),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 250,
                width: double.infinity,
                color: setTypeColor(widget.pokemon!.type1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pokemon!.name!,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(child: _coso())
                    // Row(
                    //   children: [

                    //   ]
                    // ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: setTypeColor(widget.pokemon!.type1.toString()),
                  //getBackGroundColor(widget.pokemon.types![0].type!.name!),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: TabBar(
                            labelPadding: const EdgeInsets.all(10),
                            indicatorColor:
                                setTypeColor(widget.pokemon!.type1.toString()),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            controller: _tabController,
                            tabs: [
                              Text(AppLocalizations.of(context)!.about),
                              Text(AppLocalizations.of(context)!.stats),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                AboutPokemonWidget(pokemon: widget.pokemon),
                                Container(),

                                //BaseStatsWidget(pokemon: widget.pokemon),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.25,
            top: MediaQuery.of(context).size.width * 0.25,
            child: SizedBox(
              height: 200,
              width: 200,
              child: _buildPokemonImage(),
            ),
          )
        ],
      ),
    );
  }

  Widget _coso() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: setTypeColor(
          widget.pokemon?.type1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(widget.pokemon!.name.toString()),
    );
  }
}
