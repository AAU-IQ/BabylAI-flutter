import 'package:babylai/src/domain/entity/message/sender_message_entity.dart';
import 'package:babylai/src/domain/entity/session/session_entity.dart';

import '../../../core/data/network/dio/dio_client.dart';
import '../constants/endpoints.dart';

class ClientSessionApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  ClientSessionApi(this._dioClient);

  Future<RootEntity> createSession(String helpScreenId, String optionId) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.createSession,
        data: {
          'helpScreenId': helpScreenId,
          'optionId': optionId,
        },
      );
      return RootEntity.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<SenderMessageEntity> sendMessage(
      String content, String sessionId) async {
    try {
      final res = await _dioClient.dio.post(Endpoints.sendMessage(sessionId),
          data: {"messageContent": content});
      return SenderMessageEntity.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> closeSession(String sessionId) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.closeSession(sessionId),
      );
      return res.statusCode ?? 0;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
