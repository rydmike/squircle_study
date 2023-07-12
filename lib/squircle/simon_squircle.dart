import 'dart:ui' as ui show lerpDouble;

import 'package:flutter/material.dart';

// Can be found here
// https://gist.github.com/slightfoot/e35e8d5877371417e9803143e2501b0a
class SimonSquircleBorder extends ShapeBorder {
  final double radius;
  final BorderSide side;

  const SimonSquircleBorder({
    this.radius = 5.0,
    this.side = BorderSide.none,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return SimonSquircleBorder(
      side: side.scale(t),
      radius: radius * t,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _squirclePath(rect.deflate(side.width), radius);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _squirclePath(rect, radius);
  }

  static Path _squirclePath(Rect rect, double radius) {
    final Offset c = rect.center;
    final double dx = c.dx * (1.0 / radius);
    final double dy = c.dy * (1.0 / radius);
    return Path()
      ..moveTo(c.dx, 0.0)
      ..relativeCubicTo(c.dx - dx, 0.0, c.dx, dy, c.dx, c.dy)
      ..relativeCubicTo(0.0, c.dy - dy, -dx, c.dy, -c.dx, c.dy)
      ..relativeCubicTo(-(c.dx - dx), 0.0, -c.dx, -dy, -c.dx, -c.dy)
      ..relativeCubicTo(0.0, -(c.dy - dy), dx, -c.dy, c.dx, -c.dy)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final Path path = getOuterPath(rect.deflate(side.width / 2.0),
            textDirection: textDirection);
        canvas.drawPath(path, side.toPaint());
    }
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is SimonSquircleBorder) {
      return SimonSquircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        radius: ui.lerpDouble(a.radius, radius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is SimonSquircleBorder) {
      return SimonSquircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        radius: ui.lerpDouble(radius, b.radius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    return other is SimonSquircleBorder &&
        other.side == side &&
        other.radius == radius;
  }

  @override
  int get hashCode => Object.hash(side, radius);

  @override
  String toString() {
    return 'SimonSquircleBorder(side: $side, radius: $radius)';
  }
}
