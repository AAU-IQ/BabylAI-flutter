import 'package:babylai/src/domain/entity/help_screen_entity.dart';
import 'package:babylai/src/domain/repository/help_screen/help_screen_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class GetHelpScreenUsecase extends UseCase<HelpScreenEntity, String> {

  final HelpScreenRepository _helpScreenRepository;

  GetHelpScreenUsecase(this._helpScreenRepository);

  @override
  Future<HelpScreenEntity> call({required String params}) {
    return _helpScreenRepository.getScreen(params);
  }
}