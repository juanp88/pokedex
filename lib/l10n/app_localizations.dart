import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'PokeApp'**
  String get appTitle;

  /// The main title displayed on the home screen
  ///
  /// In en, this message translates to:
  /// **'Pokedex'**
  String get pokedexTitle;

  /// Placeholder text for the search input
  ///
  /// In en, this message translates to:
  /// **'What Pokémon are you looking for?'**
  String get searchHint;

  /// Text shown when loading more Pokemon in pagination
  ///
  /// In en, this message translates to:
  /// **'Loading more Pokémon...'**
  String get loadingMorePokemon;

  /// Banner text when app is using cached data
  ///
  /// In en, this message translates to:
  /// **'Using cached data'**
  String get usingCachedData;

  /// Title when there's no internet connection
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnection;

  /// Message when offline with no cached data
  ///
  /// In en, this message translates to:
  /// **'No cached Pokemon data available.\\nConnect to the internet to load Pokemon.'**
  String get noInternetMessage;

  /// Button text to retry connection
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Title for cache management screen
  ///
  /// In en, this message translates to:
  /// **'Cache Management'**
  String get cacheManagement;

  /// Section title for cache statistics
  ///
  /// In en, this message translates to:
  /// **'Cache Statistics'**
  String get cacheStatistics;

  /// Label for cached Pokemon details count
  ///
  /// In en, this message translates to:
  /// **'Pokemon Details Cached'**
  String get pokemonDetailsCached;

  /// Label for cached Pokemon cards count
  ///
  /// In en, this message translates to:
  /// **'Pokemon Cards Cached'**
  String get pokemonCardsCached;

  /// Label for main list cache status
  ///
  /// In en, this message translates to:
  /// **'Main List Cached'**
  String get mainListCached;

  /// Label for cache size
  ///
  /// In en, this message translates to:
  /// **'Cache Size'**
  String get cacheSize;

  /// Section title for cache actions
  ///
  /// In en, this message translates to:
  /// **'Cache Actions'**
  String get cacheActions;

  /// Action to clear expired cache
  ///
  /// In en, this message translates to:
  /// **'Clear Expired Cache'**
  String get clearExpiredCache;

  /// Description for clear expired cache action
  ///
  /// In en, this message translates to:
  /// **'Remove only expired cache entries'**
  String get clearExpiredCacheDesc;

  /// Action to pre-cache images
  ///
  /// In en, this message translates to:
  /// **'Pre-cache Images'**
  String get preCacheImages;

  /// Description for pre-cache images action
  ///
  /// In en, this message translates to:
  /// **'Download images for offline viewing'**
  String get preCacheImagesDesc;

  /// Action to clear all cache
  ///
  /// In en, this message translates to:
  /// **'Clear All Cache'**
  String get clearAllCache;

  /// Description for clear all cache action
  ///
  /// In en, this message translates to:
  /// **'Remove all cached data'**
  String get clearAllCacheDesc;

  /// Section title for cache information
  ///
  /// In en, this message translates to:
  /// **'About Caching'**
  String get aboutCaching;

  /// Subsection title for cache benefits
  ///
  /// In en, this message translates to:
  /// **'Cache Benefits:'**
  String get cacheBenefits;

  /// Cache benefit point
  ///
  /// In en, this message translates to:
  /// **'• Faster app loading times'**
  String get fasterLoading;

  /// Cache benefit point
  ///
  /// In en, this message translates to:
  /// **'• Reduced data usage'**
  String get reducedDataUsage;

  /// Cache benefit point
  ///
  /// In en, this message translates to:
  /// **'• Works offline for cached Pokemon'**
  String get worksOffline;

  /// Cache benefit point
  ///
  /// In en, this message translates to:
  /// **'• Images cached for offline viewing'**
  String get imagesCached;

  /// Cache benefit point
  ///
  /// In en, this message translates to:
  /// **'• Improved user experience'**
  String get improvedExperience;

  /// Subsection title for cache details
  ///
  /// In en, this message translates to:
  /// **'Cache Details:'**
  String get cacheDetails;

  /// Cache detail point
  ///
  /// In en, this message translates to:
  /// **'• Cache expires after 24 hours'**
  String get cacheExpires;

  /// Cache detail point
  ///
  /// In en, this message translates to:
  /// **'• Automatically clears expired data'**
  String get autoClears;

  /// Cache detail point
  ///
  /// In en, this message translates to:
  /// **'• Stores Pokemon details and images'**
  String get storesData;

  /// Cache detail point
  ///
  /// In en, this message translates to:
  /// **'• Images auto-cached when viewed online'**
  String get autoImageCache;

  /// Cache detail point
  ///
  /// In en, this message translates to:
  /// **'• Manual image pre-caching available'**
  String get manualImageCache;

  /// Cache detail point
  ///
  /// In en, this message translates to:
  /// **'• Safe to clear anytime'**
  String get safeToClear;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Dialog title for clearing all cache
  ///
  /// In en, this message translates to:
  /// **'Clear All Cache'**
  String get clearAllCacheTitle;

  /// Dialog message for clearing all cache
  ///
  /// In en, this message translates to:
  /// **'This will remove all cached Pokemon data. The app will need to reload data from the internet.'**
  String get clearAllCacheMessage;

  /// Dialog title for pre-caching images
  ///
  /// In en, this message translates to:
  /// **'Pre-cache Images'**
  String get preCacheImagesTitle;

  /// Dialog message for pre-caching images
  ///
  /// In en, this message translates to:
  /// **'This will download Pokemon images for offline viewing. This may take a few minutes and use data.'**
  String get preCacheImagesMessage;

  /// Success message when cache is cleared
  ///
  /// In en, this message translates to:
  /// **'Cache cleared successfully'**
  String get cacheCleared;

  /// Success message when expired cache is cleared
  ///
  /// In en, this message translates to:
  /// **'Expired cache cleared successfully'**
  String get expiredCacheCleared;

  /// Message when starting image pre-caching
  ///
  /// In en, this message translates to:
  /// **'Starting image pre-caching...'**
  String get startingImageCache;

  /// Success message when images are pre-cached
  ///
  /// In en, this message translates to:
  /// **'Images pre-cached successfully'**
  String get imagesCacheComplete;

  /// Error message when clearing cache fails
  ///
  /// In en, this message translates to:
  /// **'Error clearing cache: {error}'**
  String errorClearingCache(String error);

  /// Error message when loading cache stats fails
  ///
  /// In en, this message translates to:
  /// **'Error loading cache stats: {error}'**
  String errorLoadingStats(String error);

  /// Error message when pre-caching images fails
  ///
  /// In en, this message translates to:
  /// **'Error pre-caching images: {error}'**
  String errorPreCachingImages(String error);

  /// Error message when Pokemon search fails
  ///
  /// In en, this message translates to:
  /// **'Pokémon \"{name}\" not found!'**
  String pokemonNotFound(String name);

  /// Tooltip for refresh stats button
  ///
  /// In en, this message translates to:
  /// **'Refresh Stats'**
  String get refreshStats;

  /// Yes response
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No response
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Generic loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Unknown value placeholder
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Pokemon species label
  ///
  /// In en, this message translates to:
  /// **'Species'**
  String get species;

  /// Pokemon height label
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// Pokemon weight label
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// Pokemon abilities label
  ///
  /// In en, this message translates to:
  /// **'Abilities'**
  String get abilities;

  /// Pokemon stats tab label
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

  /// Pokemon about tab label
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Pokemon moves tab label
  ///
  /// In en, this message translates to:
  /// **'Moves'**
  String get moves;

  /// Text shown when app is in offline mode
  ///
  /// In en, this message translates to:
  /// **'Offline mode'**
  String get offlineMode;

  /// Section title for Pokemon data
  ///
  /// In en, this message translates to:
  /// **'Pokedex Data'**
  String get pokedexData;

  /// Health Points stat abbreviation
  ///
  /// In en, this message translates to:
  /// **'HP'**
  String get hp;

  /// Attack stat abbreviation
  ///
  /// In en, this message translates to:
  /// **'ATK'**
  String get atk;

  /// Defense stat abbreviation
  ///
  /// In en, this message translates to:
  /// **'DEF'**
  String get def;

  /// Special Attack stat abbreviation
  ///
  /// In en, this message translates to:
  /// **'SATK'**
  String get satk;

  /// Special Defense stat abbreviation
  ///
  /// In en, this message translates to:
  /// **'SDEF'**
  String get sdef;

  /// Speed stat abbreviation
  ///
  /// In en, this message translates to:
  /// **'SPD'**
  String get spd;

  /// Meters unit abbreviation
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get meters;

  /// Kilograms unit abbreviation
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kilograms;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
