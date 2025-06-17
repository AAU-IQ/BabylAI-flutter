import 'package:babylai/src/data/network/constants/endpoints.dart';
import 'package:logging/logging.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'dart:async';

import '../domain/entity/message/message_entity.dart';

typedef ClosedCallback = Future<void> Function(Object? error);

class AblyService {
  ably.Realtime? _realtime;
  ably.RealtimeChannel? _channel;
  StreamSubscription<ably.Message>? _messageSubscription;

  /// Callbacks for incoming messages or errors
  Function(MessageEntity)? _onMessageReceived;
  Function(String)? _onError;
  Function()? _onConnectionStarted;

  final _logger = Logger('AblyService');

  /// Assign the onMessageReceived callback
  void setOnMessageReceivedCallback(Function(MessageEntity) callback) {
    _onMessageReceived = callback;
  }

  /// Assign the onError callback
  void setOnErrorCallback(Function(String) callback) {
    _onError = callback;
  }

  void setOnConnectionStartedCallback(Function() callback) {
    _onConnectionStarted = callback;
  }

  /// Initialize the Ably connection
  void initializeConnection(String ablyToken) {
    final clientOptions = ably.ClientOptions(
      authCallback: (params) async => ably.TokenDetails(ablyToken),
      logLevel: ably.LogLevel.verbose,
      autoConnect: false,
      echoMessages: false,
    );

    _realtime = ably.Realtime(options: clientOptions);
    _listenToConnectionEvents();
  }

  void _listenToConnectionEvents() {
    _realtime?.connection.on().listen((stateChange) {
      switch (stateChange.event) {
        case ably.ConnectionEvent.connected:
          _logger.info('Connected to Ably');
          _onConnectionStarted?.call();
          break;
        case ably.ConnectionEvent.failed:
          _logger.severe('Ably connection failed: ${stateChange.reason}');
          _onError?.call('Connection failed: ${stateChange.reason}');
          break;
        case ably.ConnectionEvent.suspended:
          _logger.warning('Ably connection suspended: ${stateChange.reason}');
          _onError?.call('Connection suspended: ${stateChange.reason}');
          break;
        case ably.ConnectionEvent.closed:
          _logger.info('Ably connection closed.');
          _onError?.call('Connection closed');
          break;
        default:
        // Handle other states if necessary
      }
    });
  }

  Future<void> startConnection() async {
    try {
      _realtime?.connect();
    } catch (error) {
      _onError?.call("Connection failed: $error");
    }
  }

  Future<void> joinGroup(String tenantId, String sessionId) async {
    if (_realtime == null) {
      _logger.warning('Ably not initialized. Call initializeConnection first.');
      return;
    }
    await _messageSubscription?.cancel();
    final channelName = 'session:$tenantId:$sessionId';
    _channel = _realtime!.channels.get(channelName);
    _messageSubscription = _channel!.subscribe().listen((message) {
      if (message.name == 'ReceiveMessage') {
        try {
          final parsedMessage = parseMessage(message.data);
          _onMessageReceived?.call(parsedMessage);
        } catch (e) {
          _onError?.call("Failed to parse message: $e");
        }
      }
    });
    _logger.info("Subscribed to channel: $channelName");
  }

  /// Stop the Ably connection
  Future<void> stopConnection() async {
    await _messageSubscription?.cancel();
    _messageSubscription = null;
    await _realtime?.close();
    _logger.info("Ably Disconnected.");
  }

  /// Check connection state
  bool isConnected() =>
      _realtime?.connection.state == ably.ConnectionState.connected;

  MessageEntity parseMessage(dynamic data) {
    if (data == null || data is! Map) {
      throw ArgumentError('Invalid arguments: $data');
    }

    try {
      final map = Map<String, dynamic>.from(data);
      final senderTypeInt = map['senderType'] as int;
      return MessageEntity(
        text: map['content'] as String,
        senderType: SenderTypeExtension.fromInt(senderTypeInt),
        needsAgent: map['needsAgent'] as bool,
        isSentByUser:
            senderTypeInt == 1, // Check if the sender type is customer
      );
    } catch (e) {
      throw ArgumentError('Error parsing arguments: $e');
    }
  }
}
