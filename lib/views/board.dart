import 'package:flutter/material.dart';

import '../model/tile.dart';

class Board extends StatefulWidget {
  Board({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
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
    // create tiles 
    List<Tile> tiles = <Tile>[];
    for (int i = 0; i < 100; i++) {
      tiles.add(Tile(i, false, false));
    }
    return Container(
      child: GridView.count(
        crossAxisCount: 10,
        children: tiles.map<Widget>((Tile tile) {
          return tile.buildTile(tile);
        }).toList(),
      ),
    );
  }
}