import 'package:flutter/material.dart';

class Gap {
  static const kZero = SizedBox();
  static const k4 = GapDimension(4);
  static const k8 = GapDimension(8);
  static const k16 = GapDimension(16);
  static const kSection = GapDimension(32);
}

class GapDimension {
  final double size;

  const GapDimension(this.size);

  SizedBox get height => SizedBox(height: size);

  SizedBox get width => SizedBox(width: size);
}
