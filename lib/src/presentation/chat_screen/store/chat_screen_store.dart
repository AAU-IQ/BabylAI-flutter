import 'package:babylai/src/data/usecase/help_screen/get_help_screen_usecase.dart';
import 'package:babylai/src/data/usecase/session/close_session_usecase.dart';
import 'package:babylai/src/data/usecase/session/create_session_usecase.dart';
import 'package:babylai/src/data/usecase/session/send_message_usecase.dart';
import 'package:babylai/src/domain/entity/help_screen_entity.dart';
import 'package:babylai/src/domain/entity/session/session_entity.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/message/message_entity.dart';
import '../../../services/signalr_service.dart';

part 'chat_screen_store.g.dart';

class ChatScreenStore = _ChatScreenStore with _$ChatScreenStore;

abstract class _ChatScreenStore with Store {

  _ChatScreenStore(
      this._createSessionUsecase,
      this._sendMessageUsecase,
      this._closeSessionUsecase,
      this._signalRService
      ) {
    _setupDisposers();
  }

  // use cases:-----------------------------------------------------------------
  final CreateSessionUsecase _createSessionUsecase;
  final SendMessageUsecase _sendMessageUsecase;
  final CloseSessionUsecase _closeSessionUsecase;
  final SignalRService _signalRService;
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

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  @action
  Future<void> initSignalRService(Option selectedOption) async {
    option = selectedOption;
    _signalRService.setOnMessageReceivedCallback((msg) {
      // Remove the "AI is thinking" bubble
      if (isThinking) {
        messages.removeWhere(
                (message) => message.text == "thinking" && message.senderType == SenderType.ai);
        isThinking = false;
      }

      if (!isManagedByAgent) {
        isManagedByAgent = msg.needsAgent || msg.senderType == SenderType.agent;
      }

      // Add the actual AI response
      messages.insert(0, msg);
    });

    _signalRService.setOnErrorCallback((error) {
      print('SignalR Error: $error');
    });

    _signalRService.initializeConnection();
  }

  @action
  void insertMessage(String msg, SenderType type, bool needsAgent, bool isSentByUser) {
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
        createSessionAndSendMessage(msg, type, needsAgent, isSentByUser);
      } else {
        sendMessage(msg, type, needsAgent, isSentByUser);
      }
    }
  }

  @action
  Future<void> sendMessage(String msg, SenderType type, bool needsAgent, bool isSentByUser) async {
    print('is connected ${_signalRService.isConnected()}');

    try {
      // Send the message to the backend if the session exists
      if (sessionEntity != null) {
        if (_signalRService.isConnected()) {
          await _sendMessageUsecase.call(
            params: SendMessageParams(content: msg, sessionId: sessionEntity!.id),
          );
        } else {
          await _signalRService.startConnection();
          await _signalRService.joinGroup(sessionEntity!.id);
          await _sendMessageUsecase.call(
            params: SendMessageParams(content: msg, sessionId: sessionEntity!.id),
          );
        }
      }
    } catch (error) {
      print("Error in sendMessage: $error");
    }
  }

  @action
  Future<void> createSessionAndSendMessage(
      String msg, SenderType type, bool needsAgent, bool isSentByUser) async {
    try {
      isLoading = true;

      // Create the session
      final params = CreateSessionParams(helpScreenId: option.helpScreenId, optionId: option.id);
      final response = await _createSessionUsecase.call(params: params);
      sessionEntity = response;

      // Start the SignalR connection
      await _signalRService.startConnection();

      // Join the group
      if (sessionEntity != null) {
        final id = sessionEntity!.id;
        await _signalRService.joinGroup(id);
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
    _signalRService.stopConnection();
    insertMessage(option.assistant.closing, SenderType.ai, false, false);
    isSessionClosed = true;
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
  }

}