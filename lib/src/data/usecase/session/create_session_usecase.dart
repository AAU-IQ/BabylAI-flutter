import 'package:babylai/src/domain/entity/session/session_entity.dart';
import 'package:babylai/src/domain/repository/session/session_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class CreateSessionUsecase extends UseCase<RootEntity, CreateSessionParams> {
  final SessionRepository _sessionRepository;

  CreateSessionUsecase(this._sessionRepository);

  @override
  Future<RootEntity> call({required CreateSessionParams params}) {
    return _sessionRepository.createSession(
        params.helpScreenId, params.optionId, params.user);
  }
}

class CreateSessionParams {
  final String helpScreenId;
  final String optionId;
  final Map<String, dynamic> user;

  CreateSessionParams({
    required this.helpScreenId,
    required this.optionId,
    required this.user,
  });
}
