import 'package:flutter/material.dart';

extension IntExtensions on int? {
  // Leaves given height of space
  Widget get height => SizedBox(height: this?.toDouble());

  // Leaves given width of space
  Widget get width => SizedBox(width: this?.toDouble());

  // Returns Size
  Size get size => Size(this!.toDouble(), this!.toDouble());
}
