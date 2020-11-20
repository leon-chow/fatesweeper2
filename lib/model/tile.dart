class Tile {
  final int id;
  bool isFlipped;
  final bool hasMine; 

  Tile(this.id, this.isFlipped, this.hasMine);

  String toString() {
    return ('Tile(${this.id}, ${this.isFlipped}, ${this.hasMine})');
  }
}

