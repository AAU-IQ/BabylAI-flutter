import 'package:babylai/src/data/network/constants/endpoints.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../domain/entity/message/message_entity.dart';

typedef ClosedCallback = Future<void> Function(Object? error);

class SignalRService {
  late HubConnection _hubConnection;

  /// Callbacks for incoming messages or errors
  Function(MessageEntity)? _onMessageReceived;
  Function(String)? _onError;
  Function()? _onConnectionStarted;

  final hubProtLogger = Logger("SignalR - hub");

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

  /// Initialize the SignalR connection
  void initializeConnection() {
    Logger.root.level = Level.ALL;
    _hubConnection = HubConnectionBuilder()
        .withUrl(Endpoints.signalRBaseUrl)
        .configureLogging(hubProtLogger)
        .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000])
        .build();

    _hubConnection.onclose(({error}) {
      if (_onError != null && error != null) {
        _onError!("Connection closed: $error");
      }
    });

    _hubConnection.on("ReceiveMessage", (arguments) {
      try {
        final message = parseMessage(arguments);
        if (_onMessageReceived != null) {
          _onMessageReceived!(message);
        }
      } catch (e) {
        if (_onError != null) {
          _onError!("Failed to parse message: $e");
        }
      }
    });

  }

  Future<void> startConnection() async {
    try {
      await _hubConnection.start();
      if (_onConnectionStarted != null) {
        _onConnectionStarted!();
      }
    } catch (error) {
      if (_onError != null) {
        _onError!("Connection failed: $error");
      }
    }
  }

  Future<void> joinGroup(String sessionId) async {
    try {
      if (_hubConnection.state == HubConnectionState.Connected) {
        await _hubConnection.invoke('JoinGroup', args: [sessionId]);
        print("Joined group with session ID: $sessionId");
      } else {
        print("Cannot send message. Hub connection is not active.");
      }
    } catch (error) {
      print(error);
    }
  }

  /// Stop the SignalR connection
  Future<void> stopConnection() async {
    if (_hubConnection.state == HubConnectionState.Connected) {
      await _hubConnection.stop();
      print("SignalR Disconnected.");
    }
  }

  /// Check connection state
  bool isConnected() => _hubConnection.state == HubConnectionState.Connected;

  MessageEntity parseMessage(List<dynamic>? arguments) {
    if (arguments == null || arguments.length < 3) {
      throw ArgumentError('Invalid arguments: $arguments');
    }

    try {
      return MessageEntity(
        text: arguments[0] as String, // The message text
        senderType: SenderTypeExtension.fromInt(arguments[1] as int), // Convert to SenderType enum
        needsAgent: arguments[2] as bool, // Whether the message needs an agent
        isSentByUser: (arguments[1] as int) == 1, // Check if the sender type is customer
      );
    } catch (e) {
      throw ArgumentError('Error parsing arguments: $e');
    }
  }

}