import 'package:ArcadeArtBox/api.dart';
import 'package:ArcadeArtBox/playerController.dart';
import 'package:ArcadeArtBox/players.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerListApp extends StatefulWidget {
  PlayerListApp({Key key}) : super(key: key);

  @override
  _PlayerListAppState createState() => _PlayerListAppState();
}

class _PlayerListAppState extends State<PlayerListApp> {
  Future<Players> futurePlayers;

  @override
  void initState() {
    super.initState();
    futurePlayers = fetchPlayers();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArcadeArtBox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Players'),
        ),
        body: Center(
          child: FutureBuilder<Players>(
            future: futurePlayers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: new ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.players.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      String title;
                      Player player = snapshot.data.players[index];

                      title = player.settings.roomName ?? player.channelName;
                      title = player.channelName;

                      return new ListTile(
                        title: Text(
                          title,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        enabled: true,
                        onTap: () {
                          Navigator.of(context).push(_createRoute(player));
                        },
                      );
                    }
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Route _createRoute(Player player) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PlayerController(player: player,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
