import 'package:babylai/src/domain/entity/session/session_entity.dart';
import 'package:babylai/src/domain/repository/session/session_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class CreateSessionUsecase extends UseCase<SessionEntity, CreateSessionParams> {

  final SessionRepository _sessionRepository;

  CreateSessionUsecase(this._sessionRepository);


  @override
  Future<SessionEntity> call({required CreateSessionParams params}) {
    return _sessionRepository.createSession(params.helpScreenId, params.optionId);
  }
}

class CreateSessionParams {
  final String helpScreenId;
  final String optionId;

  CreateSessionParams({
    required this.helpScreenId,
    required this.optionId,
  });
}