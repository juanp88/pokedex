import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'widget_test.dart' as widget_tests;
import 'models_test.dart' as model_tests;
import 'cache_service_test.dart' as cache_tests;
import 'pokemon_service_test.dart' as service_tests;
import 'widgets_test.dart' as widget_component_tests;
import 'test_config.dart';

/// Comprehensive test runner for the Pokemon app
/// Run with: flutter test test/all_tests.dart
void main() {
  setUpAll(() async {
    await TestConfig.initialize();
  });

  tearDownAll(() async {
    await TestConfig.cleanup();
  });

  group('Pokemon App - All Tests', () {
    group('Widget Tests', () {
      widget_tests.main();
    });

    group('Model Tests', () {
      model_tests.main();
    });

    group('Cache Service Tests', () {
      cache_tests.main();
    });

    group('Pokemon Service Tests', () {
      service_tests.main();
    });

    group('Widget Component Tests', () {
      widget_component_tests.main();
    });
  });
}
