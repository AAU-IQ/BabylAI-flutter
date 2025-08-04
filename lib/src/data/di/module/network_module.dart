import 'package:babylai/src/data/network/apis/client_session_api.dart';
import 'package:babylai/src/data/network/apis/help_screen_api.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:babylai/src/di/service_locator.dart';
import '../../../core/config/environment_service.dart';
import '../../../core/data/network/dio/configs/dio_configs.dart';
import '../../../core/data/network/dio/dio_client.dart';
import '../../../core/data/network/dio/interceptors/auth_interceptor.dart';
import '../../network/constants/endpoints.dart';
import '../../network/interceptors/error_interceptor.dart';
import '../../network/rest_client.dart';
import '../../sharedpref/SharedPreferenceHelper.dart';
import 'package:get_it/get_it.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // interceptors:------------------------------------------------------------
    if (!GetIt.I.isRegistered<ErrorInterceptor>()) {
      getIt.registerSingleton<ErrorInterceptor>(
        ErrorInterceptor(getIt<SharedPreferenceHelper>()),
      );
    }
    if (!GetIt.I.isRegistered<AuthInterceptor>()) {
      getIt.registerSingleton<AuthInterceptor>(
        AuthInterceptor(
          accessToken: () async =>
              await getIt<SharedPreferenceHelper>().authToken,
        ),
      );
    }

    // rest client:-------------------------------------------------------------
    if (!GetIt.I.isRegistered<RestClient>()) {
      getIt.registerSingleton(RestClient());
    }

    // dio:---------------------------------------------------------------------
    if (!GetIt.I.isRegistered<DioConfigs>()) {
      getIt.registerSingleton<DioConfigs>(
        DioConfigs(
          connectionTimeout: Endpoints.connectionTimeout,
          receiveTimeout: Endpoints.receiveTimeout,
        ),
      );
    }
    if (!GetIt.I.isRegistered<DioClient>()) {
      getIt.registerSingleton<DioClient>(
        DioClient(dioConfigs: getIt<DioConfigs>())
          ..addInterceptors(
            [
              getIt<AuthInterceptor>(),
              PrettyDioLogger(
                requestHeader: true,
                requestBody: true,
                responseBody: true,
                responseHeader: false,
                error: true,
                compact: true,
                maxWidth: 90,
                enabled: EnvironmentService.shouldEnableLogging,
              ),
              getIt<ErrorInterceptor>(),
            ],
          ),
      );
    }

    // api's:-------------------------------------------------------------------
    if (!GetIt.I.isRegistered<HelpScreenApi>()) {
      getIt.registerSingleton(HelpScreenApi(getIt<DioClient>()));
    }
    if (!GetIt.I.isRegistered<ClientSessionApi>()) {
      getIt.registerSingleton(ClientSessionApi(getIt<DioClient>()));
    }
  }
}
