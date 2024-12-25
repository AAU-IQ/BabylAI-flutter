import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../di/service_locator.dart';

class LocalModule {
  static Future<void> configureLocalModuleInjection() async {
    // preference manager:------------------------------------------------------
    // getIt.registerSingletonAsync<SharedPreferences>(
    //     SharedPreferences.getInstance);
    // getIt.registerSingleton<SharedPreferenceHelper>(
    //   SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()),
    // );


    // data sources:------------------------------------------------------------
    // getIt.registerSingleton(
    //     PostDataSource(await getIt.getAsync<SembastClient>()));
  }
}
