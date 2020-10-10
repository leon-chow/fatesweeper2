import 'package:flutter/material.dart';

class Tile {
  final int id;
  final bool isFlipped;
  final bool hasMine; 
  final double height;
  final double width;

  const Tile(this.id, this.height, this.width, this.isFlipped, this.hasMine);

  Widget buildTile(Tile tile) {
    return Container(
      /*decoration: BoxDecoration(
        border: 
      ),*/
      height: tile.height,
      width: tile.width,
      color: Colors.orange,
      child: Text("Tile #${tile.id+1}"),
    );
  }
}

