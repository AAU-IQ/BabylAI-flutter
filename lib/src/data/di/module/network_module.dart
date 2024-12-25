import 'package:babylai/src/data/network/apis/client_session_api.dart';
import 'package:babylai/src/data/network/apis/help_screen_api.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core/data/network/dio/configs/dio_configs.dart';
import '../../../core/data/network/dio/dio_client.dart';
import '../../../core/data/network/dio/interceptors/auth_interceptor.dart';
import '../../../core/data/network/dio/interceptors/logging_interceptor.dart';
import '../../../di/service_locator.dart';
import '../../network/constants/endpoints.dart';
import '../../network/interceptors/error_interceptor.dart';
import '../../network/rest_client.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // interceptors:------------------------------------------------------------
    getIt.registerSingleton<ErrorInterceptor>(ErrorInterceptor(getIt()));


    // rest client:-------------------------------------------------------------
    getIt.registerSingleton(RestClient());

    // dio:---------------------------------------------------------------------
    getIt.registerSingleton<DioConfigs>(
      const DioConfigs(
        baseUrl: Endpoints.baseUrl,
        connectionTimeout: Endpoints.connectionTimeout,
        receiveTimeout:Endpoints.receiveTimeout,
      ),
    );
    getIt.registerSingleton<DioClient>(
      DioClient(dioConfigs: getIt())
        ..addInterceptors(
          [
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              responseBody: true,
              responseHeader: false,
              error: true,
              compact: true,
              maxWidth: 90,
              enabled: kDebugMode,
            ),
            getIt<ErrorInterceptor>(),
          ],
        ),
    );

    // api's:-------------------------------------------------------------------
    getIt.registerSingleton(HelpScreenApi(getIt<DioClient>()));
    getIt.registerSingleton(ClientSessionApi(getIt<DioClient>()));
  }
}
