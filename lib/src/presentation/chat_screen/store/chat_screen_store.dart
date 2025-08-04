import 'package:babylai/src/data/usecase/session/close_session_usecase.dart';
import 'package:babylai/src/data/usecase/session/create_session_usecase.dart';
import 'package:babylai/src/data/usecase/session/send_message_usecase.dart';
import 'package:babylai/src/domain/entity/help_screen_entity.dart';
import 'package:babylai/src/domain/entity/session/session_entity.dart';
import 'package:mobx/mobx.dart';
import '../../../data/sharedpref/SharedPreferenceHelper.dart';
import '../../../domain/entity/message/message_entity.dart';
import '../../../services/ably_service.dart';

part 'chat_screen_store.g.dart';

class ChatScreenStore = _ChatScreenStore with _$ChatScreenStore;

abstract class _ChatScreenStore with Store {
  _ChatScreenStore(
      this._createSessionUsecase,
      this._sendMessageUsecase,
      this._closeSessionUsecase,
      this._ablyService,
      this._sharedPreferenceHelper) {
    _setupDisposers();
  }

  // use cases:-----------------------------------------------------------------
  final CreateSessionUsecase _createSessionUsecase;
  final SendMessageUsecase _sendMessageUsecase;
  final CloseSessionUsecase _closeSessionUsecase;
  final AblyService _ablyService;
  final SharedPreferenceHelper _sharedPreferenceHelper;

  late Option option;

  @observable
  ObservableList<MessageEntity> messages = ObservableList<MessageEntity>();

  @observable
  SessionEntity? sessionEntity;

  @observable
  bool isLoading = false;

  @observable
  bool isManagedByAgent = false;

  @observable
  bool isThinking = false;

  @observable
  bool success = false;

  @observable
  bool isSessionClosed = false;

  @observable
  bool isChatActive = true;

  @observable
  bool agentDividerShown = false;

  Function(String)? onMessageReceivedCallback;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  @action
  Future<void> initAblyService(Option selectedOption) async {
    option = selectedOption;
    _ablyService.setOnMessageReceivedCallback((msg) {
      // Remove the "AI is thinking" bubble
      if (isThinking) {
        messages.removeWhere((message) =>
            message.text == "thinking" && message.senderType == SenderType.ai);
        isThinking = false;
      }

      // Check if this is the first agent message and we need to show the divider
      if (!isManagedByAgent &&
          (msg.needsAgent || msg.senderType == SenderType.agent)) {
        isManagedByAgent = true;

        // Insert a special divider message before the agent's message
        if (!agentDividerShown) {
          messages.insert(
              0,
              MessageEntity(
                text: "agent_divider",
                senderType: SenderType.ai,
                needsAgent: false,
                isSentByUser: false,
              ));
          agentDividerShown = true;
        }
      }

      // Add the actual AI response
      messages.insert(0, msg);

      if (!isChatActive) {
        onMessageReceivedCallback?.call(msg.text);
      }
    });

    _ablyService.setOnErrorCallback((error) {});
  }

  @action
  void insertMessage(String msg, SenderType type, bool needsAgent,
      bool isSentByUser, Map<String, dynamic> userInfo) {
    messages.insert(
      0,
      MessageEntity(
        text: msg,
        senderType: type,
        needsAgent: needsAgent,
        isSentByUser: isSentByUser,
      ),
    );

    if (isSentByUser) {
      // Add a placeholder for the AI thinking bubble
      if (!isManagedByAgent) {
        messages.insert(
          0,
          MessageEntity(
            text: "thinking",
            senderType: SenderType.ai,
            needsAgent: false,
            isSentByUser: false,
          ),
        );
        isThinking = true;
      }
      // Handle session creation or message sending
      if (sessionEntity == null) {
        createSessionAndSendMessage(
            msg, type, needsAgent, isSentByUser, userInfo);
      } else {
        sendMessage(msg, type, needsAgent, isSentByUser);
      }
    }
  }

  @action
  Future<void> sendMessage(
      String msg, SenderType type, bool needsAgent, bool isSentByUser) async {
    try {
      // Send the message to the backend if the session exists
      if (sessionEntity != null) {
        if (_ablyService.isConnected()) {
          await _sendMessageUsecase.call(
            params:
                SendMessageParams(content: msg, sessionId: sessionEntity!.id),
          );
        } else {
          await _ablyService.startConnection();
          await _ablyService.joinGroup(
              sessionEntity!.tenant!.id, sessionEntity!.id);
          await _sendMessageUsecase.call(
            params:
                SendMessageParams(content: msg, sessionId: sessionEntity!.id),
          );
        }
      }
    } catch (error) {
      throw Exception("Error in sendMessage: $error");
    }
  }

  @action
  Future<void> createSessionAndSendMessage(String msg, SenderType type,
      bool needsAgent, bool isSentByUser, Map<String, dynamic> userInfo) async {
    try {
      isLoading = true;

      // Create the session
      final params = CreateSessionParams(
          helpScreenId: option.helpScreenId,
          optionId: option.id,
          user: userInfo);
      final response = await _createSessionUsecase.call(params: params);
      sessionEntity = response.session;

      if (response.ablyToken.isNotEmpty) {
        _ablyService.initializeConnection(response.ablyToken);
      } else {
        throw Exception('No token found');
      }

      // Start the Ably connection
      await _ablyService.startConnection();

      // Join the group
      if (sessionEntity != null) {
        await _ablyService.joinGroup(
            sessionEntity!.tenant!.id, sessionEntity!.id);
      }

      // After connection is established and group joined, send the message
      sendMessage(msg, type, needsAgent, isSentByUser);
    } catch (error) {
      print("Error in createSessionAndSendMessage: $error");
      success = false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> closeSession() async {
    final sessionId = sessionEntity?.id;
    if (sessionId != null)
      try {
        await _closeSessionUsecase.call(params: sessionId);
        cleanUp();
      } catch (error) {
        success = false;
      } finally {
        isLoading = false;
      }
  }

  void cleanUp() {
    sessionEntity = null;
    _ablyService.stopConnection();
    insertMessage(
        option.assistant?.closing ?? '', SenderType.ai, false, false, {});
    isSessionClosed = true;
    _sharedPreferenceHelper.removeAuthToken();
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }

    // Clear the messages list
    messages.clear();

    // Reset all observable fields to their initial states
    isLoading = false;
    isManagedByAgent = false;
    isThinking = false;
    success = false;
    isSessionClosed = false;
    agentDividerShown = false;
  }
}
