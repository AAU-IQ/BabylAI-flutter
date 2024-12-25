
import '../../../core/domain/usecase/use_case.dart';
import '../../../domain/repository/session/session_repository.dart';

class CloseSessionUsecase extends UseCase<int, String> {

  final SessionRepository _sessionRepository;

  CloseSessionUsecase(this._sessionRepository);


  @override
  Future<int> call({required String params}) {
    return _sessionRepository.closeSession(params); 
  }
}