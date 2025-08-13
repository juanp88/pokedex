import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../view_model/pokemon_view_model.dart';

class CacheManagementScreen extends StatefulWidget {
  const CacheManagementScreen({super.key});

  @override
  State<CacheManagementScreen> createState() => _CacheManagementScreenState();
}

class _CacheManagementScreenState extends State<CacheManagementScreen> {
  Map<String, dynamic> _cacheStats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCacheStats();
  }

  Future<void> _loadCacheStats() async {
    setState(() => _isLoading = true);
    try {
      final stats = await context.read<PokemonViewModel>().getCacheStats();
      setState(() {
        _cacheStats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar(
          AppLocalizations.of(context)!.errorLoadingStats(e.toString()));
    }
  }

  Future<void> _clearAllCache() async {
    final confirmed = await _showConfirmDialog(
      AppLocalizations.of(context)!.clearAllCacheTitle,
      AppLocalizations.of(context)!.clearAllCacheMessage,
    );

    if (confirmed) {
      try {
        await context.read<PokemonViewModel>().clearCache();
        _showSuccessSnackBar(AppLocalizations.of(context)!.cacheCleared);
        await _loadCacheStats();
      } catch (e) {
        _showErrorSnackBar(
            AppLocalizations.of(context)!.errorClearingCache(e.toString()));
      }
    }
  }

  Future<void> _clearExpiredCache() async {
    try {
      await context.read<PokemonViewModel>().clearExpiredCache();
      _showSuccessSnackBar(AppLocalizations.of(context)!.expiredCacheCleared);
      await _loadCacheStats();
    } catch (e) {
      _showErrorSnackBar(
          AppLocalizations.of(context)!.errorClearingCache(e.toString()));
    }
  }

  Future<void> _preCacheImages() async {
    final confirmed = await _showConfirmDialog(
      AppLocalizations.of(context)!.preCacheImagesTitle,
      AppLocalizations.of(context)!.preCacheImagesMessage,
    );

    if (confirmed) {
      try {
        _showSuccessSnackBar(AppLocalizations.of(context)!.startingImageCache);
        await context.read<PokemonViewModel>().preCacheAllImages();
        _showSuccessSnackBar(AppLocalizations.of(context)!.imagesCacheComplete);
        await _loadCacheStats();
      } catch (e) {
        _showErrorSnackBar(
            AppLocalizations.of(context)!.errorPreCachingImages(e.toString()));
      }
    }
  }

  Future<bool> _showConfirmDialog(String title, String content) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations.of(context)!.confirm),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cacheManagement),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsCard(),
                  const SizedBox(height: 20),
                  _buildActionsCard(),
                  const SizedBox(height: 20),
                  _buildInfoCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.analytics, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.cacheStatistics,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadCacheStats,
                  tooltip: AppLocalizations.of(context)!.refreshStats,
                ),
              ],
            ),
            const Divider(),
            _buildStatRow(
              AppLocalizations.of(context)!.pokemonDetailsCached,
              '${_cacheStats['pokemon_details_count'] ?? 0}',
              Icons.catching_pokemon,
            ),
            _buildStatRow(
              AppLocalizations.of(context)!.pokemonCardsCached,
              '${_cacheStats['pokemon_cards_count'] ?? 0}',
              Icons.style,
            ),
            _buildStatRow(
              AppLocalizations.of(context)!.mainListCached,
              _cacheStats['has_main_list'] == true
                  ? AppLocalizations.of(context)!.yes
                  : AppLocalizations.of(context)!.no,
              Icons.list,
            ),
            _buildStatRow(
              AppLocalizations.of(context)!.cacheSize,
              '${(_cacheStats['cache_size_mb'] ?? 0.0).toStringAsFixed(2)} MB',
              Icons.storage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.settings, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.cacheActions,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            ListTile(
              leading:
                  const Icon(Icons.cleaning_services, color: Colors.orange),
              title: Text(AppLocalizations.of(context)!.clearExpiredCache),
              subtitle:
                  Text(AppLocalizations.of(context)!.clearExpiredCacheDesc),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _clearExpiredCache,
            ),
            ListTile(
              leading: const Icon(Icons.image, color: Colors.blue),
              title: Text(AppLocalizations.of(context)!.preCacheImages),
              subtitle: Text(AppLocalizations.of(context)!.preCacheImagesDesc),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _preCacheImages,
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: Text(AppLocalizations.of(context)!.clearAllCache),
              subtitle: Text(AppLocalizations.of(context)!.clearAllCacheDesc),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _clearAllCache,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.aboutCaching,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            Text(
              AppLocalizations.of(context)!.cacheBenefits,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoPoint(AppLocalizations.of(context)!.fasterLoading),
            _buildInfoPoint(AppLocalizations.of(context)!.reducedDataUsage),
            _buildInfoPoint(AppLocalizations.of(context)!.worksOffline),
            _buildInfoPoint(AppLocalizations.of(context)!.imagesCached),
            _buildInfoPoint(AppLocalizations.of(context)!.improvedExperience),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.cacheDetails,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoPoint(AppLocalizations.of(context)!.cacheExpires),
            _buildInfoPoint(AppLocalizations.of(context)!.autoClears),
            _buildInfoPoint(AppLocalizations.of(context)!.storesData),
            _buildInfoPoint(AppLocalizations.of(context)!.autoImageCache),
            _buildInfoPoint(AppLocalizations.of(context)!.manualImageCache),
            _buildInfoPoint(AppLocalizations.of(context)!.safeToClear),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 14,
        ),
      ),
    );
  }
}
