import 'package:flutter/material.dart';

class Tile {
  final int id;
  final bool isFlipped;
  final bool hasMine; 

  const Tile(this.id, this.isFlipped, this.hasMine);

  Widget buildTile(Tile tile) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        border: Border.all(
          color: Colors.black
        ) 
      ),
      height: 50,
      width: 25,
      child: Text("Tile #${tile.id+1}"),
    );
  }
}

