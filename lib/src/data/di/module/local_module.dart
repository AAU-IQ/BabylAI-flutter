import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';
import '../../sharedpref/SharedPreferenceHelper.dart';

class LocalModule {
  static Future<void> configureLocalModuleInjection() async {
    // preference manager:------------------------------------------------------
    if (!GetIt.I.isRegistered<SharedPreferences>()) {
      getIt.registerSingletonAsync<SharedPreferences>(
          SharedPreferences.getInstance);
    }

    if (!GetIt.I.isRegistered<SharedPreferenceHelper>()) {
      getIt.registerSingleton<SharedPreferenceHelper>(
        SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()),
      );
    }
  }
}
