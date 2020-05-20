class Settings {
  final int id;
  final String roomName;
  final String playerType;

  Settings({this.id, this.roomName, this.playerType});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      roomName: json['channel_name'],
      playerType: json['player_type']
    );
  }
}

class Player {
  final int id;
  final String channelName;
  final Settings settings;

  Player({this.id, this.channelName, this.settings});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      channelName: json['channel_name'],
      settings: Settings.fromJson(json['settings'])
    );
  }
}

class Players {
  //String result;
  List<Player> players;

  Players.fromJson(List<dynamic> response) {
    this.players = [];

    for (var i = 0; i < (response.length); i++) {
      this.players.add(new Player.fromJson(response[i]));
    }
  }
}

