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

  Widget buildBoardView() {
    // create tiles 
    return Container(
      // using size of screen as height and width
      height: MediaQuery.of(context).copyWith().size.height,
      width: MediaQuery.of(context).copyWith().size.width,
      child: GridView.count(
        // hardcoded value of 10, will change depending on the difficult user selects (easy, normal, hard). with more tiles
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
        color: tile.hasMine == true ? Colors.red : Colors.white,
        border: Border.all(
          color: Colors.black
        ),
        // conditional image, will dissappear if user reveals screen
        image: tile.isFlipped == false && tile.hasMine == false ? DecorationImage(image: AssetImage('images/minesweeper_tile.png')) : null,
      ),
      child: FlatButton(
        child: Container(
          child: Text("${tile.id+1}"),
        ),
        onPressed: () {
          setState(() {
            if (tile.hasMine == true) {
              gameOver(context);
            }
            print('flipped tile ${tile.id+1}');
            tile.isFlipped = true;
            print(tile.toString());
          });
        },
      ),
    );
  }
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

  void gameOver(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.title),
          content: Container(
            child: Text('Game Over! What now?'),
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
}