import 'dart:io';
import 'package:flutter/foundation.dart';

class ConnectivityHelper {
  /// Check if device has internet connectivity
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      debugPrint('Connectivity check error: $e');
      return false;
    }
  }

  /// Check connectivity with a timeout
  static Future<bool> hasInternetConnectionWithTimeout({
    Duration timeout = const Duration(seconds: 3),
  }) async {
    try {
      final result =
          await InternetAddress.lookup('google.com').timeout(timeout);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      debugPrint('Connectivity check error: $e');
      return false;
    }
  }
}
