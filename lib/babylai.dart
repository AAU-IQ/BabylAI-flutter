library babylai;

import 'package:babylai/src/core/config/environment_config.dart';
import 'package:babylai/src/core/config/environment_service.dart';
import 'package:babylai/src/data/sharedpref/SharedPreferenceHelper.dart';
import 'package:babylai/src/di/service_locator.dart';
import 'package:babylai/src/presentation/chat_screen/store/chat_screen_store.dart';
import 'package:babylai/src/presentation/help_screen/start_screen.dart';
import 'package:flutter/material.dart';

// Export environment configuration classes for client use
export 'package:babylai/src/core/config/environment_config.dart';

class BabylAI {
  static late ChatScreenStore _chatScreenStore;
  static Function(String)? _onMessageReceived;
  static late BuildContext _context;
  static late String _locale;
  static late ThemeMode? _theme;
  static late String _screenId;
  static late Map<String, dynamic> _userInfo;

  /// Function to handle token refresh
  static Future<String> Function()? _tokenCallback;

  /// Set a callback function that will be called when the token needs to be refreshed
  /// The callback should return a Future<String> with the new token
  static void setTokenCallback(Future<String> Function() callback) {
    _tokenCallback = callback;
  }

  /// Method to get a fresh token - exposed for internal use by interceptors
  static Future<String?> getToken() async {
    if (_tokenCallback != null) {
      try {
        return await _tokenCallback!();
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<void> _inject() async {
    try {
      await ServiceLocator.configureDependencies();
      _chatScreenStore = getIt<ChatScreenStore>();

      // Get token and handle it safely
      String? token = await getToken();
      if (token != null && token.isNotEmpty) {
        _storeToken(token);
      } else {
        throw Exception('No token callback provided');
      }
    } catch (error) {
      throw Exception('Error injecting dependencies: $error');
    }
  }

  static void _storeToken(String? token) {
    if (token != null && token.isNotEmpty) {
      getIt<SharedPreferenceHelper>().saveAuthToken(token);
    } else {
      throw Exception('Attempted to store null or empty token');
    }
  }

  /// Initialize the BabylAI SDK with environment configuration
  /// This must be called before using any other SDK methods
  static void initialize({
    required EnvironmentConfig environmentConfig,
    required String screenId,
    required Map<String, dynamic> userInfo,
  }) {
    EnvironmentService.initialize(environmentConfig);
    _screenId = screenId;
    _userInfo = userInfo;
  }

  /// Configure the SDK (deprecated - use initialize instead)
  @Deprecated('Use initialize() method instead')
  static Future<void> configure(String screenId) async {
    // If not initialized with environment config, default to development
    if (!EnvironmentService.isInitialized) {
      EnvironmentService.initialize(EnvironmentConfig.development());
    }
    _screenId = screenId;
    await _inject();
  }

  static Future<void> lauchActiveChat() async {
    // Check if SDK is initialized
    if (!EnvironmentService.isInitialized) {
      throw Exception(
          'BabylAI SDK not initialized. Please call BabylAI.initialize() with proper environment configuration before launching.');
    }

    // Inject dependencies if not already done
    await _inject();

    // Check if we have a valid token before proceeding
    if (!await _validateToken()) {
      print('Error: No valid token available for launching active chat');
      return;
    }

    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (context) => StartScreen(
          screenId: _screenId,
          locale: _locale,
          theme: _theme,
          directChat: true,
          userInfo: _userInfo,
          onBack: () {
            Navigator.of(_context).pop();
          },
        ),
      ),
    );
  }

  /// Validates that a token exists and is valid
  /// Returns true if valid, false otherwise
  static Future<bool> _validateToken() async {
    // First check if we have a stored token
    final storedToken = await getIt<SharedPreferenceHelper>().authToken;

    // If no stored token, try to get a fresh one
    if (storedToken == null || storedToken.isEmpty) {
      final freshToken = await getToken();

      if (freshToken == null || freshToken.isEmpty) {
        return false;
      }

      // Store the fresh token
      _storeToken(freshToken);
      return true;
    }

    return true;
  }

  static Future<void> launch(
    String locale,
    ThemeMode? theme,
    BuildContext context, {
    Function(String)? onMessageReceived,
  }) async {
    // Check if SDK is initialized
    if (!EnvironmentService.isInitialized) {
      throw Exception(
          'BabylAI SDK not initialized. Please call BabylAI.initialize() with proper environment configuration before launching.');
    }

    _context = context;
    _onMessageReceived = onMessageReceived;
    _locale = locale;
    _theme = theme;

    // Inject dependencies if not already done
    await _inject();

    // Check if we have a valid token before proceeding
    if (!await _validateToken()) {
      throw Exception(
          'No valid token available. Please ensure you have called BabylAI.setTokenCallback() with a valid token provider function.');
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartScreen(
          screenId: _screenId,
          locale: locale,
          theme: theme,
          userInfo: _userInfo,
          onBack: () {
            Navigator.of(_context).pop();
          },
        ),
      ),
    );

    _chatScreenStore.onMessageReceivedCallback = (message) {
      if (!_chatScreenStore.isChatActive) {
        _onMessageReceived?.call(message);
      }
    };
  }
}
