import 'package:babylai/src/domain/entity/help_screen_entity.dart';

import '../../../core/data/network/dio/dio_client.dart';
import '../constants/endpoints.dart';

class HelpScreenApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  HelpScreenApi(this._dioClient);

  Future<HelpScreenEntity> getHelpScreen(String id) async {
    try {
      final res = await _dioClient.dio
          .get('${Endpoints.getScreen}/$id');
      return HelpScreenEntity.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
