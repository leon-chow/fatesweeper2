import 'dart:math';

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
  int tileCount = 10;
  
  @override 
  void initState() {
    super.initState();
    // add tiles
    createBoard();
  }

  void reload() {
    createBoard();
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

  // widget function to build the board view, iteratively calls buildTile function
  Widget buildBoardView() {
    // create tiles 
    return Container(
      // using size of screen as height and width
      height: MediaQuery.of(context).copyWith().size.height,
      width: MediaQuery.of(context).copyWith().size.width,
      child: GridView.count(
        // hardcoded value of 10, will change depending on the difficult user selects (easy, normal, hard). with more tiles
        crossAxisCount: tileCount,
        children: tiles.map<Widget>((Tile tile) {
          return buildTile(tile);
        }).toList(),
      ),
    );
  }

  // widget function to individually build the tile 
  Widget buildTile(Tile tile) {
    return Container(
      decoration: BoxDecoration(
        color: tile.hasMine == true ? Colors.red : Colors.white,
        border: Border.all(
          color: Colors.black
        ),
        // conditional image, will dissappear if user reveals screen
        image: tile.isFlipped == false ? DecorationImage(image: AssetImage('images/minesweeper_tile.png')) : null,
      ),
      child: FlatButton(
        child: Container(
          child: Text(""),
        ),
        // handle tile flipping
        onPressed: () {
          setState(() {
            if (tile.hasMine == true) {
              gameOver(context);
            } else {
              print('flipped tile ${tile.id+1}');
              tile.isFlipped = true;
              revealAdjacentTiles(tile);
            }
          });
        },
      ),
    );
  }

  // function to create the board
  void createBoard() {
    tiles = <Tile>[];
    Set<int> mineLocations = {};

    // generate unique list of mines 
    for (int i = 0; i < 10; i++) {
      mineLocations.add(Random().nextInt(100) + 1);
    }

    for (int i = 0; i < 100; i++) {
      bool hasMine = false;
      if (mineLocations.contains(i)) {
        hasMine = true;
      }
      tiles.add(Tile(i, false, hasMine));
    }
  }

  // function to handle game over 
  void gameOver(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.title),
          content: Container(
            child: Text('Game Over! Now what?'),
          ),
          actions: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  child: Text('Restart'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      reload();
                    });
                  },
                ),
              ],
            ),
          ],
        );
      }
    );
  }

  // recursive function that will keep revealing tiles that were clicked next
  void revealAdjacentTiles(Tile tile) {
    // adjacent top tile check
    if (tile.id + 1 - tileCount > 0) {
      if (tiles[tile.id-tileCount].hasMine == false && tiles[tile.id-tileCount].isFlipped == false) {
        tiles[tile.id-tileCount].isFlipped = true;
        revealAdjacentTiles(tiles[tile.id-tileCount]);
      }
    } 
    
    // adjacent right tile check
    if ((tile.id + 1) % tileCount != 0 && tile.id + 1 <= tiles.length && tiles[tile.id+1].isFlipped == false) {
      if (tiles[tile.id+1].hasMine == false) {
        tiles[tile.id+1].isFlipped = true;
        revealAdjacentTiles(tiles[tile.id+1]);
      } 
    }
    
    // adjacent bottom tile check 
    if (tile.id + 1 + tileCount <= tiles.length) {
      if (tiles[tile.id+tileCount].hasMine == false && tiles[tile.id+tileCount].isFlipped == false) {
        tiles[tile.id+tileCount].isFlipped = true;
        revealAdjacentTiles(tiles[tile.id+tileCount]);
      } 
    }
    
    // adjacent left tile check 
    if ((tile.id) % tileCount != 0 && tile.id - 1 >= 0) {
      if (tiles[tile.id-1].hasMine == false && tiles[tile.id-1].isFlipped == false) {
        tiles[tile.id-1].isFlipped = true;
        revealAdjacentTiles(tiles[tile.id-1]);
      } 
    }
  }

  // recursive function that will keep revealing tiles that were clicked next
  // TODO: recursively reveal tiles until countAdjMines is not 0, keep going upward to reveal
  /*void revealAdjacentTiles(Tile tile) {
    // adjacent top tile check
    if (tile.id + 1 - tileCount > 0) {
      if (tiles[tile.id-tileCount].hasMine == false && tiles[tile.id-tileCount].isFlipped == false) {
        tiles[tile.id-tileCount].isFlipped = true;
      } if (!hasAdjacentMines(tiles[tile.id-tileCount])) {
        revealAdjacentTiles(tiles[tile.id-tileCount]);
      }
    } 
  }*/

  bool hasAdjacentMines(Tile tile) {
    // top left, top middle, top right adjacent mine check
    if (tiles[tile.id-1-tileCount].hasMine || tiles[tile.id-tileCount].hasMine || tiles[tile.id-tileCount+1].hasMine || 
      // left, right tile
      tiles[tile.id-1].hasMine || tiles[tile.id+1].hasMine || 
      // bottom left, bottom middle, bottom right tiles
      tiles[tile.id+tileCount-1].hasMine || tiles[tile.id+tileCount].hasMine || tiles[tile.id+tileCount+1].hasMine) {
        return true;
    } else {
      return false;
    }
  }
}