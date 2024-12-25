import 'package:babylai/babylai.dart';
import 'package:babylai/src/constants/app_theme.dart';
import 'package:babylai/src/presentation/help_screen/help_screen.dart';
import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';

import '../../../l10n/gen/app_localizations.dart';

class StartScreen extends StatefulWidget {
  final String locale;
  final ThemeMode? theme;

  const StartScreen({
    super.key,
    required this.locale,
    this.theme
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  final _noScreenshot = NoScreenshot.instance;


  @override
  void initState() {
    super.initState();
    disableScreenshot();
  }

  void disableScreenshot() async {
    await _noScreenshot.screenshotOff();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: widget.theme ?? ThemeMode.light,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(widget.locale),
      home: HelpScreen(),
    );
  }

}
