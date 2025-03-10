import 'package:babylai/src/data/usecase/help_screen/get_help_screen_usecase.dart';
import 'package:babylai/src/domain/entity/help_screen_entity.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/message/message_entity.dart';

part 'help_screen_store.g.dart';

class HelpScreenStore = _HelpScreenStore with _$HelpScreenStore;

abstract class _HelpScreenStore with Store {
  _HelpScreenStore(this._getHelpScreenUsecase);

  // use cases:-----------------------------------------------------------------
  final GetHelpScreenUsecase _getHelpScreenUsecase;

  @observable
  HelpScreenEntity? helpScreen;

  @observable
  bool isLoading = false;

  @observable
  bool success = false;

  @action
  Future<void> getHelpScreen() async {
    isLoading = true;
    try {
      final response = await _getHelpScreenUsecase.call(params: '');
      helpScreen = response;
      success = true;
    } catch (error) {
      success = false;
    } finally {
      isLoading = false;
    }
  }
}
