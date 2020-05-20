import 'dart:convert';
import 'dart:io';

import 'package:web_socket_channel/io.dart';

final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

void sendChannelAction(String action) {

}

class PlayerSocket {
  IOWebSocketChannel socket;
  String url;
  String playerName;

  PlayerSocket(String uri, String playerName) {
    this.playerName = playerName;
    this.url = 'ws://' + uri + '/ws/player/' + '?room=' + this.playerName;
    WebSocket.connect(this.url).timeout(Duration(hours: 2))
      .then((ws) {
        try {
          this.socket = new IOWebSocketChannel(ws);
        } catch (e) {
          print('Error happened when opening a new websocket connection. ${e.toString()}');
        }
      }
    );
  }

  void sendAction(String action) {
    SocketMessage socketMessage = SocketMessage(action, this.playerName);

    String jsonString = jsonEncode(socketMessage);

    this.socket.sink.add(jsonString);
  }
}

class SocketMessage {
  String action;
  String roomId;

  SocketMessage(this.action, this.roomId);

  Map toJson() => {
    "action": action,
    "room_id": roomId,
  };
}