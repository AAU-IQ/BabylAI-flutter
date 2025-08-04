import '../../../core/config/environment_service.dart';

class Endpoints {
  Endpoints._();

  // receiveTimeout
  static int get receiveTimeout => EnvironmentService.receiveTimeout;

  // connectTimeout
  static int get connectionTimeout => EnvironmentService.connectionTimeout;

  // base url - dynamically retrieved from environment service
  static String get baseUrl => EnvironmentService.baseUrl;

  // endpoints
  static String get getScreen => "${baseUrl}Client/ClientHelpScreen";

  static String get createSession =>
      "${baseUrl}Client/ClientChatSession/create-session";

  static String sendMessage(String sessionId) {
    return "Client/ClientChatSession/$sessionId/send-message";
  }

  static String messages(String sessionId) {
    return "Client/ClientChatSession/$sessionId/messages";
  }

  static String closeSession(String sessionId) {
    return "Client/ClientChatSession/$sessionId/close";
  }
}
