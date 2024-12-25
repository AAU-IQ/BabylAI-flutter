
import 'package:babylai/src/domain/entity/help_screen_entity.dart';

abstract class HelpScreenRepository {
  Future<HelpScreenEntity> getScreen(String id);
}