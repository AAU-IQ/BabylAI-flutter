import 'package:babylai/src/data/network/apis/client_session_api.dart';
import 'package:babylai/src/domain/repository/session/session_repository.dart';

import '../../../domain/entity/message/sender_message_entity.dart';
import '../../../domain/entity/session/session_entity.dart';

class SessionRepositoryImpl extends SessionRepository {
  final ClientSessionApi _clientSessionApi;

  SessionRepositoryImpl(this._clientSessionApi);

  @override
  Future<RootEntity> createSession(String helpScreenId, String optionId) {
    return _clientSessionApi.createSession(helpScreenId, optionId);
  }

  @override
  Future<SenderMessageEntity> sendMessage(String content, String sessionId) {
    return _clientSessionApi.sendMessage(content, sessionId);
  }

  @override
  Future<int> closeSession(String sessionId) {
    return _clientSessionApi.closeSession(sessionId);
  }
}
