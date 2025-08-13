import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_app/helpers/map_cardColor.dart';
import 'package:poke_app/models/pokemon.dart';
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
      return Image.asset(
        'assets/images/pokeLoad.gif',
        fit: BoxFit.contain,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Image.asset(
        'assets/images/pokeLoad.gif',
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/images/pokeLoad.gif',
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
        title: const Text(
          'Pokemon',
          style: TextStyle(color: Colors.yellow),
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
                            tabs: const [
                              Text('About'),
                              Text('Base Stats'),
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
