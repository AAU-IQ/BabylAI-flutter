// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatScreenStore on _ChatScreenStore, Store {
  late final _$messagesAtom =
      Atom(name: '_ChatScreenStore.messages', context: context);

  @override
  ObservableList<MessageEntity> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<MessageEntity> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$sessionEntityAtom =
      Atom(name: '_ChatScreenStore.sessionEntity', context: context);

  @override
  SessionEntity? get sessionEntity {
    _$sessionEntityAtom.reportRead();
    return super.sessionEntity;
  }

  @override
  set sessionEntity(SessionEntity? value) {
    _$sessionEntityAtom.reportWrite(value, super.sessionEntity, () {
      super.sessionEntity = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ChatScreenStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isManagedByAgentAtom =
      Atom(name: '_ChatScreenStore.isManagedByAgent', context: context);

  @override
  bool get isManagedByAgent {
    _$isManagedByAgentAtom.reportRead();
    return super.isManagedByAgent;
  }

  @override
  set isManagedByAgent(bool value) {
    _$isManagedByAgentAtom.reportWrite(value, super.isManagedByAgent, () {
      super.isManagedByAgent = value;
    });
  }

  late final _$isThinkingAtom =
      Atom(name: '_ChatScreenStore.isThinking', context: context);

  @override
  bool get isThinking {
    _$isThinkingAtom.reportRead();
    return super.isThinking;
  }

  @override
  set isThinking(bool value) {
    _$isThinkingAtom.reportWrite(value, super.isThinking, () {
      super.isThinking = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ChatScreenStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$isSessionClosedAtom =
      Atom(name: '_ChatScreenStore.isSessionClosed', context: context);

  @override
  bool get isSessionClosed {
    _$isSessionClosedAtom.reportRead();
    return super.isSessionClosed;
  }

  @override
  set isSessionClosed(bool value) {
    _$isSessionClosedAtom.reportWrite(value, super.isSessionClosed, () {
      super.isSessionClosed = value;
    });
  }

  late final _$isChatActiveAtom =
      Atom(name: '_ChatScreenStore.isChatActive', context: context);

  @override
  bool get isChatActive {
    _$isChatActiveAtom.reportRead();
    return super.isChatActive;
  }

  @override
  set isChatActive(bool value) {
    _$isChatActiveAtom.reportWrite(value, super.isChatActive, () {
      super.isChatActive = value;
    });
  }

  late final _$agentDividerShownAtom =
      Atom(name: '_ChatScreenStore.agentDividerShown', context: context);

  @override
  bool get agentDividerShown {
    _$agentDividerShownAtom.reportRead();
    return super.agentDividerShown;
  }

  @override
  set agentDividerShown(bool value) {
    _$agentDividerShownAtom.reportWrite(value, super.agentDividerShown, () {
      super.agentDividerShown = value;
    });
  }

  late final _$initSignalRServiceAsyncAction =
      AsyncAction('_ChatScreenStore.initSignalRService', context: context);

  @override
  Future<void> initSignalRService(Option selectedOption) {
    return _$initSignalRServiceAsyncAction
        .run(() => super.initSignalRService(selectedOption));
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('_ChatScreenStore.sendMessage', context: context);

  @override
  Future<void> sendMessage(
      String msg, SenderType type, bool needsAgent, bool isSentByUser) {
    return _$sendMessageAsyncAction
        .run(() => super.sendMessage(msg, type, needsAgent, isSentByUser));
  }

  late final _$createSessionAndSendMessageAsyncAction = AsyncAction(
      '_ChatScreenStore.createSessionAndSendMessage',
      context: context);

  @override
  Future<void> createSessionAndSendMessage(
      String msg, SenderType type, bool needsAgent, bool isSentByUser) {
    return _$createSessionAndSendMessageAsyncAction.run(() =>
        super.createSessionAndSendMessage(msg, type, needsAgent, isSentByUser));
  }

  late final _$closeSessionAsyncAction =
      AsyncAction('_ChatScreenStore.closeSession', context: context);

  @override
  Future<void> closeSession() {
    return _$closeSessionAsyncAction.run(() => super.closeSession());
  }

  late final _$_ChatScreenStoreActionController =
      ActionController(name: '_ChatScreenStore', context: context);

  @override
  void insertMessage(
      String msg, SenderType type, bool needsAgent, bool isSentByUser) {
    final _$actionInfo = _$_ChatScreenStoreActionController.startAction(
        name: '_ChatScreenStore.insertMessage');
    try {
      return super.insertMessage(msg, type, needsAgent, isSentByUser);
    } finally {
      _$_ChatScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messages: ${messages},
sessionEntity: ${sessionEntity},
isLoading: ${isLoading},
isManagedByAgent: ${isManagedByAgent},
isThinking: ${isThinking},
success: ${success},
isSessionClosed: ${isSessionClosed},
isChatActive: ${isChatActive},
agentDividerShown: ${agentDividerShown}
    ''';
  }
}
