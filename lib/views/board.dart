import 'package:flutter/material.dart';

import '../model/tile.dart';

class Board extends StatefulWidget {
  Board({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Tile> tiles = <Tile>[];
  
  @override 
  void initState() {
    super.initState();
    for (int i = 0; i < 100; i++) {
      tiles.add(Tile(i, false, false));
    }
  }
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
    return Container(
      child: GridView.count(
        crossAxisCount: 10,
        children: tiles.map<Widget>((Tile tile) {
          return buildTile(tile);
        }).toList(),
      ),
    );
  }

  Widget buildTile(Tile tile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black
        ),
        image: tile.isFlipped == false ? DecorationImage(image: AssetImage('images/minesweeper_tile.png')) : null,
      ),
      child: FlatButton(
        child: Container(
          child: Text("${tile.id+1}"),
        ),
        onPressed: () {
          setState(() {
            print('flipped tile ${tile.id+1}');
            tile.isFlipped = true;
            print(tile.toString());
          });
        },
      ),
    );
  }
}