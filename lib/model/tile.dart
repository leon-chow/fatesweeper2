import 'package:flutter/material.dart';

class Tile {
  final int id;
  final bool isFlipped;
  final bool hasMine; 

  const Tile(this.id, this.isFlipped, this.hasMine);

  Widget buildTile(Tile tile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black
        ),
        image: DecorationImage(image: AssetImage('images/minesweeper_tile.png')),
      ),
      child: FlatButton(
        child: Container(
          child: Text("${tile.id+1}"),
        ),
        onPressed: () {
          print('flipped tile ${tile.id+1}');
        },
      ),
    );
  }
}

