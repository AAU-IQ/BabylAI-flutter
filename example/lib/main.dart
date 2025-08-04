import 'dart:convert';
import 'dart:io';

import 'package:example/toast_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:babylai/babylai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default theme
  String _locale = 'en'; // Default language
  BabylAIEnvironment _selectedEnvironment =
      BabylAIEnvironment.development; // Default environment
  bool _isSDKInitialized = false;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _toggleLanguage(bool isArabic) {
    setState(() {
      _locale = isArabic ? 'ar' : 'en';
    });
  }

  void _changeEnvironment(BabylAIEnvironment environment) {
    setState(() {
      _selectedEnvironment = environment;
      _isSDKInitialized =
          false; // Reset initialization when environment changes
    });
  }

  void _initializeSDK(BuildContext context) {
    try {
      EnvironmentConfig config;

      switch (_selectedEnvironment) {
        case BabylAIEnvironment.production:
          config = EnvironmentConfig.production(
            enableLogging: false,
          );
          break;
        case BabylAIEnvironment.development:
          config = EnvironmentConfig.development(
            enableLogging: true,
          );
          break;
      }

      BabylAI.initialize(
        environmentConfig: config,
        screenId: 'YOUR_SCREEN_ID',
        userInfo: {
          'name': 'John Doe',
          'email': 'john.doe@example.com',
          'phone': '1234567890',
        },
      );

      BabylAI.setTokenCallback(() async {
        return await getTokenExample();
      });

      setState(() {
        _isSDKInitialized = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'BabylAI initialized with ${_getEnvironmentName(_selectedEnvironment)} environment'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to initialize SDK: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getEnvironmentName(BabylAIEnvironment env) {
    switch (env) {
      case BabylAIEnvironment.production:
        return 'Production';
      case BabylAIEnvironment.development:
        return 'Development';
    }
  }

  Future<String> getTokenExample() async {
    final url = Uri.parse('YOUR_BACKEND_URL');
    final HttpClient httpClient = HttpClient();

    try {
      // Create the request
      HttpClientRequest request = await httpClient.postUrl(url);

      // Set headers
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');

      final body = jsonEncode({
        'apiKey': 'YOUR_API_KEY',
        'tenantId': 'YOUR_TENANT_ID',
      });

      request.write(body);

      // Send request and get response
      HttpClientResponse response = await request.close();

      // Read response body
      final responseBody = await response.transform(utf8.decoder).join();
      final jsonResponse = jsonDecode(responseBody);
      // Access token directly from the root level
      if (jsonResponse != null && jsonResponse['token'] != null) {
        return jsonResponse['token'];
      } else {
        if (kDebugMode) {
          print('Invalid token response structure: $jsonResponse');
        }
        return '';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return '';
    } finally {
      httpClient.close();
    }
  }

  @override
  void initState() {
    super.initState();
    // SDK will be initialized when user selects environment and clicks initialize
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BabylAI App',
      theme: ThemeData.light(),
      home: BabylAIExample(
        themeMode: _themeMode,
        locale: _locale,
        selectedEnvironment: _selectedEnvironment,
        isSDKInitialized: _isSDKInitialized,
        onThemeToggle: _toggleTheme,
        onLanguageToggle: _toggleLanguage,
        onEnvironmentChange: _changeEnvironment,
        onInitializeSDK: _initializeSDK,
        onGetToken: getTokenExample,
      ),
    );
  }
}

class BabylAIExample extends StatelessWidget {
  final ThemeMode themeMode;
  final String locale;
  final BabylAIEnvironment selectedEnvironment;
  final bool isSDKInitialized;
  final ValueChanged<bool> onThemeToggle;
  final ValueChanged<bool> onLanguageToggle;
  final ValueChanged<BabylAIEnvironment> onEnvironmentChange;
  final ValueChanged<BuildContext> onInitializeSDK;
  final Function onGetToken;

  const BabylAIExample({
    Key? key,
    required this.themeMode,
    required this.locale,
    required this.selectedEnvironment,
    required this.isSDKInitialized,
    required this.onThemeToggle,
    required this.onLanguageToggle,
    required this.onEnvironmentChange,
    required this.onInitializeSDK,
    required this.onGetToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = themeMode == ThemeMode.dark;
    final isArabic = locale == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: const Text('BabylAI Environment Example'),
        backgroundColor:
            isSDKInitialized ? Colors.green[100] : Colors.orange[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Environment Selection Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Environment Configuration',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),

                      // Environment Selection
                      const Text('Select Environment:',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      ...[
                        BabylAIEnvironment.production,
                        BabylAIEnvironment.development
                      ].map((env) => RadioListTile<BabylAIEnvironment>(
                            title: Text(_getEnvironmentDisplayName(env)),
                            subtitle: Text(_getEnvironmentDescription(env)),
                            value: env,
                            groupValue: selectedEnvironment,
                            onChanged: isSDKInitialized
                                ? null
                                : (value) {
                                    if (value != null)
                                      onEnvironmentChange(value);
                                  },
                          )),

                      const SizedBox(height: 16),

                      // Initialize SDK Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: isSDKInitialized
                              ? null
                              : () => onInitializeSDK(context),
                          icon: Icon(isSDKInitialized
                              ? Icons.check_circle
                              : Icons.settings),
                          label: Text(isSDKInitialized
                              ? 'SDK Initialized'
                              : 'Initialize SDK'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isSDKInitialized ? Colors.green : Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),

                      if (isSDKInitialized)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '✓ SDK initialized with ${_getEnvironmentDisplayName(selectedEnvironment)} environment',
                            style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // App Settings Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'App Settings',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 16),

                      // Theme Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Dark Theme',
                              style: TextStyle(fontSize: 16)),
                          Switch(
                            value: isDarkTheme,
                            onChanged: onThemeToggle,
                          ),
                        ],
                      ),

                      const Divider(),

                      // Language Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Arabic Language',
                              style: TextStyle(fontSize: 16)),
                          Switch(
                            value: isArabic,
                            onChanged: onLanguageToggle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Launch BabylAI Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: isSDKInitialized
                      ? () {
                          BabylAI.launch(locale, themeMode, context,
                              onMessageReceived: (message) {
                            ToastNotification.show(
                                context: context,
                                message: message,
                                title: 'new message',
                                onTap: () {
                                  BabylAI.lauchActiveChat();
                                });
                          });
                        }
                      : null,
                  icon: const Icon(Icons.chat_bubble),
                  label: const Text('Launch BabylAI Chat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(20),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              if (!isSDKInitialized)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Please initialize the SDK first by selecting an environment and clicking "Initialize SDK"',
                    style: TextStyle(
                        color: Colors.grey, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ),

              const SizedBox(height: 20),

              // Environment Info Card
              Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Environment Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                          '• Production: Uses production API, logging disabled'),
                      Text(
                          '• Development: Uses dev/testing API, logging enabled'),
                      const SizedBox(height: 8),
                      Text(
                        'Current: ${_getEnvironmentDisplayName(selectedEnvironment)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[800]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getEnvironmentDisplayName(BabylAIEnvironment env) {
    switch (env) {
      case BabylAIEnvironment.production:
        return 'Production';
      case BabylAIEnvironment.development:
        return 'Development';
    }
  }

  String _getEnvironmentDescription(BabylAIEnvironment env) {
    switch (env) {
      case BabylAIEnvironment.production:
        return 'Production API, logging disabled';
      case BabylAIEnvironment.development:
        return 'Development API, logging enabled';
    }
  }
}
