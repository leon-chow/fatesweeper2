import 'package:flutter/material.dart';

import 'board.dart';
import 'tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Fatesweeper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildBoardView(),
    );
  }

  Widget buildBoardView() {
    List<Tile> tiles = <Tile>[];
    int tileCount = 10;
    for (int i = 0; i < 100; i++) {
      tiles.add(Tile(i, 50.0, 50.0, false, false));
    }
    return GridView.count(
      crossAxisCount: 10,
      children: tiles.map<Widget>((Tile tile) {
        return tile.buildTile(tile);
      }).toList(),
    );
  }
}
