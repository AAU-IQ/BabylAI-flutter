import 'package:babylai/src/domain/entity/message/sender_message_entity.dart';
import 'package:babylai/src/domain/entity/session/session_entity.dart';

abstract class SessionRepository {

  Future<SessionEntity> createSession(String helpScreenId, String optionId);
  Future<SenderMessageEntity> sendMessage(String content, String sessionId);
  Future<int> closeSession(String sessionId);

}