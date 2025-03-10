import 'dart:convert';
import 'dart:io';

import 'package:example/toast_notification.dart';
import 'package:flutter/material.dart';
import 'package:babylai/babylai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default theme
  String _locale = 'en'; // Default language

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

  Future<String> getToken() async {
    final url =
        Uri.parse('https://babylai.net/api/Auth/client/get-babylai-token');
    final HttpClient httpClient = HttpClient();

    try {
      // Create the request
      HttpClientRequest request = await httpClient.postUrl(url);

      // Set headers
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');

      // Send request and get response
      HttpClientResponse response = await request.close();

      // Read response body
      final responseBody = await response.transform(utf8.decoder).join();
      final jsonResponse = jsonDecode(responseBody);
      // Access token directly from the root level
      if (jsonResponse != null && jsonResponse['token'] != null) {
        return jsonResponse['token'];
      } else {
        print('Invalid token response structure: $jsonResponse');
        return '';
      }
    } catch (e) {
      print('Error: $e');
      return '';
    } finally {
      httpClient.close();
    }
  }

  @override
  void initState() {
    super.initState();
    BabylAI.configure();
    BabylAI.setTokenCallback(() async {
      return await getToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BabylAI App',
      theme: ThemeData.light(),
      home: BabylAIExample(
        themeMode: _themeMode,
        locale: _locale,
        onThemeToggle: _toggleTheme,
        onLanguageToggle: _toggleLanguage,
        onGetToken: getToken,
      ),
    );
  }
}

class BabylAIExample extends StatelessWidget {
  final ThemeMode themeMode;
  final String locale;
  final ValueChanged<bool> onThemeToggle;
  final ValueChanged<bool> onLanguageToggle;
  final Function onGetToken;

  const BabylAIExample({
    Key? key,
    required this.themeMode,
    required this.locale,
    required this.onThemeToggle,
    required this.onLanguageToggle,
    required this.onGetToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = themeMode == ThemeMode.dark;
    final isArabic = locale == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: const Text('BabylAI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Dark Theme'),
                Switch(
                  value: isDarkTheme,
                  onChanged: onThemeToggle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Arabic Language'),
                Switch(
                  value: isArabic,
                  onChanged: onLanguageToggle,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
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
                },
                child: Text('Launch Babyl AI'))
          ],
        ),
      ),
    );
  }
}
