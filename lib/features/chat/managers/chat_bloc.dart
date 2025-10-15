import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/status.dart' as websocket_status;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'chat_state.dart';

part 'chat_events.dart';

class ChatBloc extends Bloc<ChatEvents, ChatState> {
  ChatBloc() : super(ChatState.initial()) {
    on<ChatMessageReceived>(_onMessageReceived);
    on<ChatMessageSend>(_onMessageSend);
    initializeWebSocket();
  }

  Future initializeWebSocket() async {
    final uri = Uri.parse("ws://192.168.10.206:8888/chat");
    websocket = WebSocketChannel.connect(uri);
    await websocket.ready;
    subscription = websocket.stream.listen((message) {
      final Map<String, dynamic> msg = jsonDecode(message);
      add(ChatMessageReceived(message: msg));
    });
  }

  late final WebSocketChannel websocket;
  late final StreamSubscription subscription;

  @override
  Future<void> close() async {
    super.close();
    websocket.sink.close(websocket_status.normalClosure, "Connection closed.");
    subscription.cancel();
  }

  Future _onMessageReceived(
    ChatMessageReceived event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(messages: [...state.messages, event.message]));
  }

  Future _onMessageSend(ChatMessageSend event, Emitter<ChatState> emit) async {
    final message = {
      "message": event.message,
      "direction": "from",
      "date": DateTime.now().toLocal().toIso8601String(),
    };
    websocket.sink.add(jsonEncode(message));
    emit(state.copyWith(messages: [...state.messages, message]));
  }
}
