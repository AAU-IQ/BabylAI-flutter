import 'dart:async';
import 'package:babylai/src/data/network/apis/client_session_api.dart';
import 'package:babylai/src/data/network/apis/help_screen_api.dart';
import 'package:babylai/src/data/repository/help_screen/help_screen_repository_impl.dart';
import 'package:babylai/src/data/repository/session/session_repository_impl.dart';
import 'package:babylai/src/domain/repository/help_screen/help_screen_repository.dart';
import 'package:babylai/src/domain/repository/session/session_repository.dart';

import '../../../di/service_locator.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    // getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
    //   getIt<SharedPreferenceHelper>(),
    // ));
    //
    // getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
    //   getIt<SharedPreferenceHelper>(),
    // ));
    //
    if (!getIt.isRegistered<HelpScreenRepository>()) {
      getIt.registerSingleton<HelpScreenRepository>(
        HelpScreenRepositoryImpl(
          getIt<HelpScreenApi>(),
        ),
      );
    }

    if (!getIt.isRegistered<SessionRepository>()) {
      getIt.registerSingleton<SessionRepository>(
        SessionRepositoryImpl(
          getIt<ClientSessionApi>(),
        ),
      );
    }
  }
}
