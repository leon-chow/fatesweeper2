class Tile {
  final int id;
  final bool isFlipped;
  final bool hasMine; 
  final int height;
  final int width;

  Tile(this.id, this.height, this.width, this.isFlipped, this.hasMine);
}

