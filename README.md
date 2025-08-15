# Pokedex Flutter App

This is an upgrade from a very old basic project of Pokedex app, the idea is to see if with the MVVM architecture as it was, it's possible to adde new feature in a clean and scalable way. The app consumes the [PokeAPI](https://pokeapi.co/api/v2/) to display Pokemon information with a beautiful, type-based color-coded interface.

## Features

- **Pokemon List**: Browse through Pokemon with infinite scroll pagination
- **Type-based Colors**: Each Pokemon card displays with colors matching their primary type
- **Detailed View**: Tap any Pokemon to see detailed information
- **Offline Support**: Cached data allows browsing previously viewed Pokemon offline
- **Internationalization**: Multi-language support
- **Smooth Animations**: Custom Pokeball loading animations and transitions
- **Image Caching**: Optimized image loading with fallback sprites

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone this project**
   ```bash
   git clone https://github.com/juanp88/pokedex.git
   cd pokedex
   ```

2. **Install required packages**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Architecture

This app follows the MVVM (Model-View-ViewModel) pattern with Provider for state management:

- **Models**: Data structures for Pokemon, Cards, and API responses
- **Views**: UI screens (Home, Detail)
- **ViewModels**: Business logic and state management
- **Services**: API calls and caching logic
- **Widgets**: Reusable UI components

## Key Components

### Caching System
- **Smart Caching**: 24-hour cache expiration with offline fallback
- **Image Pre-caching**: Pokemon sprites and artwork cached for offline viewing
- **Cache Management**: Clear cache functionality with automatic data refresh

### Type-based Theming
- Each Pokemon type has its own color scheme
- Cards and UI elements adapt to the Pokemon's primary type
- Consistent color mapping across the entire app

### Offline Support
- Graceful degradation when network is unavailable
- Cached data remains accessible offline
- Automatic retry functionality when connection is restored

## API Endpoints Used

- `https://pokeapi.co/api/v2/pokemon/` - Pokemon list with pagination
- `https://pokeapi.co/api/v2/pokemon/{name}` - Individual Pokemon details
- `https://pokeapi.co/api/v2/pokemon-species/{id}` - Pokemon species information

## Dependencies

Key packages used in this project:

- `provider` - State management
- `http` - API calls
- `cached_network_image` - Image caching
- `hive` - Local database
- `shared_preferences` - Simple data persistence
- `flutter_cache_manager` - Advanced caching

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).
