// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PokeApp';

  @override
  String get pokedexTitle => 'Pokedex';

  @override
  String get searchHint => 'What Pokémon are you looking for?';

  @override
  String get loadingMorePokemon => 'Loading more Pokémon...';

  @override
  String get usingCachedData => 'Using cached data';

  @override
  String get noInternetConnection => 'No Internet Connection';

  @override
  String get noInternetMessage =>
      'No cached Pokemon data available.\\nConnect to the internet to load Pokemon.';

  @override
  String get retry => 'Retry';

  @override
  String get cacheManagement => 'Cache Management';

  @override
  String get cacheStatistics => 'Cache Statistics';

  @override
  String get pokemonDetailsCached => 'Pokemon Details Cached';

  @override
  String get pokemonCardsCached => 'Pokemon Cards Cached';

  @override
  String get mainListCached => 'Main List Cached';

  @override
  String get cacheSize => 'Cache Size';

  @override
  String get cacheActions => 'Cache Actions';

  @override
  String get clearExpiredCache => 'Clear Expired Cache';

  @override
  String get clearExpiredCacheDesc => 'Remove only expired cache entries';

  @override
  String get preCacheImages => 'Pre-cache Images';

  @override
  String get preCacheImagesDesc => 'Download images for offline viewing';

  @override
  String get clearAllCache => 'Clear All Cache';

  @override
  String get clearAllCacheDesc => 'Remove all cached data';

  @override
  String get aboutCaching => 'About Caching';

  @override
  String get cacheBenefits => 'Cache Benefits:';

  @override
  String get fasterLoading => '• Faster app loading times';

  @override
  String get reducedDataUsage => '• Reduced data usage';

  @override
  String get worksOffline => '• Works offline for cached Pokemon';

  @override
  String get imagesCached => '• Images cached for offline viewing';

  @override
  String get improvedExperience => '• Improved user experience';

  @override
  String get cacheDetails => 'Cache Details:';

  @override
  String get cacheExpires => '• Cache expires after 24 hours';

  @override
  String get autoClears => '• Automatically clears expired data';

  @override
  String get storesData => '• Stores Pokemon details and images';

  @override
  String get autoImageCache => '• Images auto-cached when viewed online';

  @override
  String get manualImageCache => '• Manual image pre-caching available';

  @override
  String get safeToClear => '• Safe to clear anytime';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get clearAllCacheTitle => 'Clear All Cache';

  @override
  String get clearAllCacheMessage =>
      'This will remove all cached Pokemon data. The app will need to reload data from the internet.';

  @override
  String get preCacheImagesTitle => 'Pre-cache Images';

  @override
  String get preCacheImagesMessage =>
      'This will download Pokemon images for offline viewing. This may take a few minutes and use data.';

  @override
  String get cacheCleared => 'Cache cleared successfully';

  @override
  String get expiredCacheCleared => 'Expired cache cleared successfully';

  @override
  String get startingImageCache => 'Starting image pre-caching...';

  @override
  String get imagesCacheComplete => 'Images pre-cached successfully';

  @override
  String errorClearingCache(String error) {
    return 'Error clearing cache: $error';
  }

  @override
  String errorLoadingStats(String error) {
    return 'Error loading cache stats: $error';
  }

  @override
  String errorPreCachingImages(String error) {
    return 'Error pre-caching images: $error';
  }

  @override
  String pokemonNotFound(String name) {
    return 'Pokémon \"$name\" not found!';
  }

  @override
  String get refreshStats => 'Refresh Stats';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get loading => 'Loading...';

  @override
  String get unknown => 'Unknown';

  @override
  String get species => 'Species';

  @override
  String get height => 'Height';

  @override
  String get weight => 'Weight';

  @override
  String get abilities => 'Abilities';

  @override
  String get stats => 'Stats';

  @override
  String get about => 'About';

  @override
  String get moves => 'Moves';

  @override
  String get offlineMode => 'Offline mode';

  @override
  String get pokedexData => 'Pokedex Data';

  @override
  String get hp => 'HP';

  @override
  String get atk => 'ATK';

  @override
  String get def => 'DEF';

  @override
  String get satk => 'SATK';

  @override
  String get sdef => 'SDEF';

  @override
  String get spd => 'SPD';

  @override
  String get meters => 'm';

  @override
  String get kilograms => 'kg';
}
