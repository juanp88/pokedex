// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'PokeApp';

  @override
  String get pokedexTitle => 'Pokedex';

  @override
  String get searchHint => '¿Qué Pokémon estás buscando?';

  @override
  String get loadingMorePokemon => 'Cargando más Pokémon...';

  @override
  String get usingCachedData => 'Usando datos en caché';

  @override
  String get noInternetConnection => 'Sin Conexión a Internet';

  @override
  String get noInternetMessage =>
      'No hay datos de Pokémon en caché disponibles.\\nConéctate a internet para cargar Pokémon.';

  @override
  String get retry => 'Reintentar';

  @override
  String get cacheManagement => 'Gestión de Caché';

  @override
  String get cacheStatistics => 'Estadísticas de Caché';

  @override
  String get pokemonDetailsCached => 'Detalles de Pokémon en Caché';

  @override
  String get pokemonCardsCached => 'Tarjetas de Pokémon en Caché';

  @override
  String get mainListCached => 'Lista Principal en Caché';

  @override
  String get cacheSize => 'Tamaño de Caché';

  @override
  String get cacheActions => 'Acciones de Caché';

  @override
  String get clearExpiredCache => 'Limpiar Caché Expirado';

  @override
  String get clearExpiredCacheDesc =>
      'Eliminar solo entradas de caché expiradas';

  @override
  String get preCacheImages => 'Pre-cachear Imágenes';

  @override
  String get preCacheImagesDesc =>
      'Descargar imágenes para visualización offline';

  @override
  String get clearAllCache => 'Limpiar Todo el Caché';

  @override
  String get clearAllCacheDesc => 'Eliminar todos los datos en caché';

  @override
  String get aboutCaching => 'Acerca del Caché';

  @override
  String get cacheBenefits => 'Beneficios del Caché:';

  @override
  String get fasterLoading => '• Tiempos de carga más rápidos';

  @override
  String get reducedDataUsage => '• Uso reducido de datos';

  @override
  String get worksOffline => '• Funciona offline para Pokémon en caché';

  @override
  String get imagesCached => '• Imágenes en caché para visualización offline';

  @override
  String get improvedExperience => '• Experiencia de usuario mejorada';

  @override
  String get cacheDetails => 'Detalles del Caché:';

  @override
  String get cacheExpires => '• El caché expira después de 24 horas';

  @override
  String get autoClears => '• Limpia automáticamente datos expirados';

  @override
  String get storesData => '• Almacena detalles e imágenes de Pokémon';

  @override
  String get autoImageCache => '• Imágenes auto-cacheadas al verlas online';

  @override
  String get manualImageCache => '• Pre-caché manual de imágenes disponible';

  @override
  String get safeToClear => '• Seguro de limpiar en cualquier momento';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get clearAllCacheTitle => 'Limpiar Todo el Caché';

  @override
  String get clearAllCacheMessage =>
      'Esto eliminará todos los datos de Pokémon en caché. La app necesitará recargar datos desde internet.';

  @override
  String get preCacheImagesTitle => 'Pre-cachear Imágenes';

  @override
  String get preCacheImagesMessage =>
      'Esto descargará imágenes de Pokémon para visualización offline. Puede tomar unos minutos y usar datos.';

  @override
  String get cacheCleared => 'Caché limpiado exitosamente';

  @override
  String get expiredCacheCleared => 'Caché expirado limpiado exitosamente';

  @override
  String get startingImageCache => 'Iniciando pre-caché de imágenes...';

  @override
  String get imagesCacheComplete => 'Imágenes pre-cacheadas exitosamente';

  @override
  String errorClearingCache(String error) {
    return 'Error limpiando caché: $error';
  }

  @override
  String errorLoadingStats(String error) {
    return 'Error cargando estadísticas de caché: $error';
  }

  @override
  String errorPreCachingImages(String error) {
    return 'Error pre-cacheando imágenes: $error';
  }

  @override
  String pokemonNotFound(String name) {
    return '¡Pokémon \"$name\" no encontrado!';
  }

  @override
  String get refreshStats => 'Actualizar Estadísticas';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get loading => 'Cargando...';

  @override
  String get unknown => 'Desconocido';

  @override
  String get species => 'Especie';

  @override
  String get height => 'Altura';

  @override
  String get weight => 'Peso';

  @override
  String get abilities => 'Habilidades';

  @override
  String get stats => 'Estadísticas';

  @override
  String get about => 'Acerca de';

  @override
  String get moves => 'Movimientos';

  @override
  String get offlineMode => 'Modo offline';

  @override
  String get pokedexData => 'Datos de Pokedex';

  @override
  String get hp => 'PS';

  @override
  String get atk => 'ATQ';

  @override
  String get def => 'DEF';

  @override
  String get satk => 'ATESP';

  @override
  String get sdef => 'DEFESP';

  @override
  String get spd => 'VEL';

  @override
  String get meters => 'm';

  @override
  String get kilograms => 'kg';
}
