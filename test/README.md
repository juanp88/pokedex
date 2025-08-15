# Pokemon App Tests

This directory contains comprehensive tests for the Pokemon Flutter app.

## Test Structure

### Core Tests
- **`widget_test.dart`** - Main app widget tests and Pokemon card rendering
- **`models_test.dart`** - Data model tests (Pokemon, CardModel, API responses)
- **`cache_service_test.dart`** - Caching functionality tests
- **`pokemon_service_test.dart`** - API service tests
- **`widgets_test.dart`** - Individual widget component tests

### Utilities
- **`test_config.dart`** - Test configuration and mock data
- **`all_tests.dart`** - Comprehensive test runner

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Specific Test File
```bash
flutter test test/widget_test.dart
flutter test test/models_test.dart
flutter test test/cache_service_test.dart
```

### Run All Tests with Coverage
```bash
flutter test --coverage
```

### Run Tests in Watch Mode
```bash
flutter test --watch
```

## Test Coverage

The tests cover:

### ✅ Widget Testing
- App initialization and loading states
- Pokemon card rendering with correct data
- Type-based color display
- List view handling
- Navigation between screens

### ✅ Model Testing
- JSON serialization/deserialization
- Data validation
- Edge cases (missing data, null values)
- Type conversion

### ✅ Service Testing
- API endpoint formatting
- Cache management
- Offline functionality
- Error handling

### ✅ Color System Testing
- Type-based color mapping
- Case insensitive type handling
- Default color fallbacks
- All 18 Pokemon types

### ✅ Cache Testing
- Data persistence
- Expiration handling
- Offline mode
- Cache statistics

## Mock Data

Test configuration includes mock data for:
- Pokemon details (Pikachu example)
- Pokemon list responses
- Species information
- All Pokemon types and their colors

## Integration Tests

Some tests are marked as integration tests and require network access:
- API endpoint validation
- Real data fetching
- Network error handling

These tests are skipped by default but can be enabled when network is available.

## Test Environment Setup

Tests automatically handle:
- Hive database initialization
- SharedPreferences mocking
- Flutter binding setup
- Cleanup after tests

## Adding New Tests

When adding new features, ensure to add corresponding tests:

1. **Widget tests** for new UI components
2. **Model tests** for new data structures
3. **Service tests** for new API endpoints
4. **Integration tests** for complete user flows

Follow the existing patterns in the test files for consistency.