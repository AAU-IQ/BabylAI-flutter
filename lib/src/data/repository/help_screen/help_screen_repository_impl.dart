import 'package:babylai/src/data/network/apis/help_screen_api.dart';
import 'package:babylai/src/domain/repository/help_screen/help_screen_repository.dart';

import '../../../domain/entity/help_screen_entity.dart';

class HelpScreenRepositoryImpl extends HelpScreenRepository {

  final HelpScreenApi _helpScreenApi;

  HelpScreenRepositoryImpl(this._helpScreenApi);

  @override
  Future<HelpScreenEntity> getScreen(String id) async {
    return await _helpScreenApi.getHelpScreen(id);
  }

}