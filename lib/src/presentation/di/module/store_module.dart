import 'dart:async';
import 'package:babylai/src/data/usecase/help_screen/get_help_screen_usecase.dart';
import 'package:babylai/src/data/usecase/session/close_session_usecase.dart';
import 'package:babylai/src/data/usecase/session/create_session_usecase.dart';
import 'package:babylai/src/data/usecase/session/send_message_usecase.dart';
import 'package:babylai/src/presentation/chat_screen/store/chat_screen_store.dart';
import 'package:babylai/src/presentation/help_screen/store/help_screen_store.dart';
import 'package:babylai/src/services/signalr_service.dart';

import '../../../di/service_locator.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    // getIt.registerFactory(() => ErrorStore());
    // getIt.registerFactory(() => FormErrorStore());
    // getIt.registerFactory(
    //   () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    // );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<HelpScreenStore>(
      HelpScreenStore(
        getIt<GetHelpScreenUsecase>(),
      ),
    );

    getIt.registerSingleton<ChatScreenStore>(
      ChatScreenStore(
        getIt<CreateSessionUsecase>(),
        getIt<SendMessageUsecase>(),
        getIt<CloseSessionUsecase>(),
        SignalRService()
      ),
    );
  }
}
