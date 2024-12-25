import 'package:flutter/material.dart';
import '../../l10n/gen/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  // Add shortcuts for specific fields, if needed
  String get title => localizations.title;
}