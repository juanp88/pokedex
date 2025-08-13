import 'package:flutter/material.dart';
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
      _showErrorSnackBar('Error loading cache stats: $e');
    }
  }

  Future<void> _clearAllCache() async {
    final confirmed = await _showConfirmDialog(
      'Clear All Cache',
      'This will remove all cached Pokemon data. The app will need to reload data from the internet.',
    );

    if (confirmed) {
      try {
        await context.read<PokemonViewModel>().clearCache();
        _showSuccessSnackBar('Cache cleared successfully');
        await _loadCacheStats();
      } catch (e) {
        _showErrorSnackBar('Error clearing cache: $e');
      }
    }
  }

  Future<void> _clearExpiredCache() async {
    try {
      await context.read<PokemonViewModel>().clearExpiredCache();
      _showSuccessSnackBar('Expired cache cleared successfully');
      await _loadCacheStats();
    } catch (e) {
      _showErrorSnackBar('Error clearing expired cache: $e');
    }
  }

  Future<void> _preCacheImages() async {
    final confirmed = await _showConfirmDialog(
      'Pre-cache Images',
      'This will download Pokemon images for offline viewing. This may take a few minutes and use data.',
    );

    if (confirmed) {
      try {
        _showSuccessSnackBar('Starting image pre-caching...');
        await context.read<PokemonViewModel>().preCacheAllImages();
        _showSuccessSnackBar('Images pre-cached successfully');
        await _loadCacheStats();
      } catch (e) {
        _showErrorSnackBar('Error pre-caching images: $e');
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
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Confirm'),
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
        title: const Text('Cache Management'),
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
                const Text(
                  'Cache Statistics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadCacheStats,
                  tooltip: 'Refresh Stats',
                ),
              ],
            ),
            const Divider(),
            _buildStatRow(
              'Pokemon Details Cached',
              '${_cacheStats['pokemon_details_count'] ?? 0}',
              Icons.catching_pokemon,
            ),
            _buildStatRow(
              'Pokemon Cards Cached',
              '${_cacheStats['pokemon_cards_count'] ?? 0}',
              Icons.style,
            ),
            _buildStatRow(
              'Main List Cached',
              _cacheStats['has_main_list'] == true ? 'Yes' : 'No',
              Icons.list,
            ),
            _buildStatRow(
              'Cache Size',
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
            const Row(
              children: [
                Icon(Icons.settings, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Cache Actions',
                  style: TextStyle(
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
              title: const Text('Clear Expired Cache'),
              subtitle: const Text('Remove only expired cache entries'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _clearExpiredCache,
            ),
            ListTile(
              leading: const Icon(Icons.image, color: Colors.blue),
              title: const Text('Pre-cache Images'),
              subtitle: const Text('Download images for offline viewing'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _preCacheImages,
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text('Clear All Cache'),
              subtitle: const Text('Remove all cached data'),
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
            const Row(
              children: [
                Icon(Icons.info, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'About Caching',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const Text(
              'Cache Benefits:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoPoint('• Faster app loading times'),
            _buildInfoPoint('• Reduced data usage'),
            _buildInfoPoint('• Works offline for cached Pokemon'),
            _buildInfoPoint('• Images cached for offline viewing'),
            _buildInfoPoint('• Improved user experience'),
            const SizedBox(height: 16),
            const Text(
              'Cache Details:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoPoint('• Cache expires after 24 hours'),
            _buildInfoPoint('• Automatically clears expired data'),
            _buildInfoPoint('• Stores Pokemon details and images'),
            _buildInfoPoint('• Images auto-cached when viewed online'),
            _buildInfoPoint('• Manual image pre-caching available'),
            _buildInfoPoint('• Safe to clear anytime'),
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
