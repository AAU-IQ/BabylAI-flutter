import 'package:babylai/src/domain/entity/message/sender_message_entity.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../../domain/repository/session/session_repository.dart';

class SendMessageUsecase extends UseCase<SenderMessageEntity, SendMessageParams> {

  final SessionRepository _sessionRepository;

  SendMessageUsecase(this._sessionRepository);


  @override
  Future<SenderMessageEntity> call({required SendMessageParams params}) {
    return _sessionRepository.sendMessage(params.content, params.sessionId);
  }

}

class SendMessageParams {
  final String content;
  final String sessionId;

  SendMessageParams({
    required this.content,
    required this.sessionId,
  });
}