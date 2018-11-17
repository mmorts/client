import 'dart:html';
import 'dart:math';

class MouseCoords {
  final DivElement _root;

  final DivElement _xEl;

  final DivElement _yEl;

  MouseCoords(this._root, this._xEl, this._yEl);

  factory MouseCoords.mount(DivElement root) {
    final DivElement xEl = root.querySelector("div.xcoord");
    final DivElement yEl = root.querySelector("div.ycoord");
    return MouseCoords(root, xEl, yEl);
  }

  void updateData(Point point) {
    _xEl.text = point.x.toString();
    _yEl.text = point.y.toString();
  }
}