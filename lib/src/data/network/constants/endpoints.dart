class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://babylai.net/api/";

  static const String devBaseUrl =
      "https://babylai-be.dev.kvm.creativeadvtech.ml/";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // endpoints
  static const String getScreen = devBaseUrl + "Client/ClientHelpScreen";

  static const String createSession =
      devBaseUrl + "Client/ClientChatSession/create-session";

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
