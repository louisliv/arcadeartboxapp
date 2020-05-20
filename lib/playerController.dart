import 'dart:convert';

import 'package:ArcadeArtBox/players.dart';
import 'package:ArcadeArtBox/utils.dart';
import 'package:ArcadeArtBox/websocket.dart';
import 'package:flutter/material.dart';

Text _createTitle(String title, BuildContext context) {
  return Text(
    title,
    style: Theme.of(context).textTheme.headline5,
  );
}

Container _createButtons(BuildContext context, PlayerSocket playerSocket, String title) {
  return Container(
    child: new FutureBuilder(
      future: DefaultAssetBundle.of(context)
        .loadString('assets/data/globals.json'),
      builder: (context, snapshot) {
        Map globals = jsonDecode(snapshot.data.toString());
        List globalButtons = globals['buttons'];
        List<Widget> buttons = [];

        for (var i = 0; i < (globalButtons.length); i++) {
          String action = globalButtons[i]['id'];

          buttons.add(
            Center(
              child:RawMaterialButton(
                constraints: BoxConstraints.expand(height:100,width:100),
                onPressed: () {
                  playerSocket.sendAction(action);
                },
                elevation: 2.0,
                fillColor: getColorFromHex(globalButtons[i]['btn_class']),
                child: Icon(
                  getIconFromString(globalButtons[i]['icon'], globalButtons[i]['fontFamily']),
                  size: 45.0,
                  color: getColorFromHex(globalButtons[i]['text_class']),
                ),
                shape: CircleBorder(),
              )
            )
          );
        }
        return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(0),
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            crossAxisCount: 3,
            children: buttons,
          );
      }
    )
  );
}

class PlayerController extends StatelessWidget {
  final Player player;

  PlayerController({Key key, @required this.player}) : super(key: key);

  Widget build(BuildContext context) {
    final title = this.player.settings.roomName ?? this.player.channelName;
    PlayerSocket playerSocket = new PlayerSocket(
      '10.0.0.216:8000', 
      this.player.channelName
    );
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _createButtons(context, playerSocket, title),
    );
  }
}
