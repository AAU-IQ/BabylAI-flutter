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

  @override
  void initState() {
    BabylAI.config();
    super.initState();
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
      ),
    );
  }
}


class BabylAIExample extends StatelessWidget {
  final ThemeMode themeMode;
  final String locale;
  final ValueChanged<bool> onThemeToggle;
  final ValueChanged<bool> onLanguageToggle;

  const BabylAIExample({
    Key? key,
    required this.themeMode,
    required this.locale,
    required this.onThemeToggle,
    required this.onLanguageToggle,
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
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  BabylAI.launch(context, locale, themeMode);
                },
                child: Text('Launch Babyl AI'))
          ],
        ),
      ),
    );
  }
}