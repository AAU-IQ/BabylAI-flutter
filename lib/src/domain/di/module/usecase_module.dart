import 'dart:async';
import 'package:babylai/src/data/usecase/help_screen/get_help_screen_usecase.dart';
import 'package:babylai/src/data/usecase/session/close_session_usecase.dart';
import 'package:babylai/src/data/usecase/session/create_session_usecase.dart';
import 'package:babylai/src/data/usecase/session/send_message_usecase.dart';
import 'package:babylai/src/domain/repository/help_screen/help_screen_repository.dart';
import 'package:babylai/src/domain/repository/session/session_repository.dart';

import '../../../di/service_locator.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // user:--------------------------------------------------------------------
    // getIt.registerSingleton<IsLoggedInUseCase>(
    //   IsLoggedInUseCase(getIt<UserRepository>()),
    // );
    // getIt.registerSingleton<SaveLoginStatusUseCase>(
    //   SaveLoginStatusUseCase(getIt<UserRepository>()),
    // );
    // getIt.registerSingleton<LoginUseCase>(
    //   LoginUseCase(getIt<UserRepository>()),
    // );

    if (!getIt.isRegistered<GetHelpScreenUsecase>()) {
      getIt.registerSingleton<GetHelpScreenUsecase>(
        GetHelpScreenUsecase(getIt<HelpScreenRepository>()),
      );
    }

    if (!getIt.isRegistered<CreateSessionUsecase>()) {
      getIt.registerSingleton<CreateSessionUsecase>(
        CreateSessionUsecase(getIt<SessionRepository>()),
      );
    }

    if (!getIt.isRegistered<SendMessageUsecase>()) {
      getIt.registerSingleton<SendMessageUsecase>(
        SendMessageUsecase(getIt<SessionRepository>()),
      );
    }

    if (!getIt.isRegistered<CloseSessionUsecase>()) {
      getIt.registerSingleton<CloseSessionUsecase>(
        CloseSessionUsecase(getIt<SessionRepository>()),
      );
    }
  }
}
