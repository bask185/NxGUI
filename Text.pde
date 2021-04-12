class Text {
  char c;
  color col;
  
  Text(char c, color col) {
    this.c = c;
    this.col = col;
  }
  
  void setText(char c, color col) {
    this.c = c;
    this.col = col;
  }
  
  char getText() {
    return c;
  }
  
  color getCol() {
    return col;
  }
}