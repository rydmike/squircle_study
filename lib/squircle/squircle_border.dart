// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

// ignore_for_file: comment_references

/// A rectangle border with continuous corners.
///
/// A shape similar to a rounded rectangle, but with a smoother transition from
/// the sides to the rounded corners.
///
/// The rendered shape roughly approximates that of a super-ellipse. In this
/// shape, the curvature of each 90º corner around the length of the arc is
/// approximately a gaussian curve instead of a step function as with a
/// traditional quarter circle round. The rendered rectangle is roughly a
/// super-ellipse with an n value of 5.
///
/// In an attempt to keep the shape of the rectangle the same regardless of its
/// dimension (and to avoid clipping of the shape), the radius will
/// automatically be lessened if its width or height is less than ~3x the
/// declared radius. The new resulting radius will always be maximal in respect
/// to the dimensions of the given rectangle.
///
/// To achieve the corner smoothness with this shape, ~50% more pixels in each
/// dimensions are used to render each corner. As such, the ~3 represents twice
/// the ratio (ie. ~3/2) of a corner's declared radius and the actual height and
/// width of pixels that are used to construct it. For example, if a
/// rectangle had and a corner radius of 25, in reality ~38 pixels in each
/// dimension would be used to construct a corner and so ~76px x ~76px would be
/// the minimal size needed to render this rectangle.
///
/// This shape will always have 4 linear edges and 4 90º curves. However, for
/// rectangles with small values of width or height (ie.  <20 lpx) and a low
/// aspect ratio (ie. <0.3), the rendered shape will appear to have just 2
/// linear edges and 2 180º curves.
///
/// The example below shows how to render a continuous rectangle on screen.
///
/// {@tool sample}
/// ```dart
/// Widget build(BuildContext context) {
///   return Container(
///     alignment: Alignment.center,
///     child: Material(
///       color: Colors.blueAccent[400],
///       shape: const SquircleBorder(cornerRadius: 75.0),
///       child: const SizedBox(
///         height: 200.0,
///         width: 200.0,
///       ),
///     ),
///   );
/// }
/// ```
/// {@end-tool}
///
/// The source code for this Squircle implementation is from this never merged
/// PR https://github.com/flutter/flutter/pull/27523 which in the comment
/// https://github.com/flutter/flutter/pull/27523#issuecomment-597373748 was
/// praised for its iOS like fidelity.
///
/// The original code can be found here:
/// https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_rectangle_border.dart
///
/// In this issue https://github.com/flutter/flutter/issues/91523 it is
/// claimed here that [ContinuousRectangleBorder] requires a borderRadius
/// of ~24 to resemble the iOS RoundedRectangle with a cornerRadius of ~10.2,
/// a factor of 2.3529x
///
/// See also:
///
/// * [RoundedRectangleBorder], which is a rectangle whose corners are
///   precisely quarter circles.
/// * [SquircleStadiumBorder], which is a stadium whose two edges have a
///   continuous transition into its two 180º curves.
/// * [StadiumBorder], which is a rectangle with semi-circles on two parallel
///   edges.
class SquircleBorder extends OutlinedBorder {
  /// Creates a continuous cornered rectangle border.
  ///
  /// The [cornerRadius] argument must not be null.
  const SquircleBorder({
    super.side,
    this.borderRadius = BorderRadius.zero,
  });

  /// The radius for each corner.
  ///
  /// Negative radius values are clamped to 0.0 by [getInnerPath] and
  /// [getOuterPath].
  ///
  /// While a [BorderRadiusGeometry] is accepted as input, this version of
  /// the [SquircleBorder] still draws symmetrical corners using the largest
  /// provided corner radius as its symmetrical radius, and if a corners was
  /// elliptical, the shorter radius is used to determine the radius for the
  /// symmetrical Squircle.
  ///
  /// A later update may add support for asymmetric corners. In this version
  /// using any other type than:
  ///
  /// `BorderRadius.all(Radius.circular(radius))` does not produce any
  /// useful different results.
  final BorderRadiusGeometry borderRadius;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) {
    return SquircleBorder(
      side: side.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is SquircleBorder) {
      return SquircleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is SquircleBorder) {
      return SquircleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  double _clampToShortest(RRect rrect, double value) {
    return value > rrect.shortestSide / 2 ? rrect.shortestSide / 2 : value;
  }

  Path _getPath(RRect rrect) {
    late double limitedRadius;
    final double width = rrect.width;
    final double height = rrect.height;
    final double centerX = rrect.center.dx;
    final double centerY = rrect.center.dy;

    // Radius is clamped to shortest side divided with 2, meaning radius is
    // clamped to stadium radius.
    //
    // If the rounded rect is elliptical we only use the shorter radius,
    // this version does not handle elliptical shapes.
    final double tlRadiusX =
        math.max(0.0, _clampToShortest(rrect, rrect.tlRadiusX));
    final double tlRadiusY =
        math.max(0.0, _clampToShortest(rrect, rrect.tlRadiusY));
    final double tlRadius = math.min(tlRadiusX, tlRadiusY);
    //
    final double trRadiusX =
        math.max(0.0, _clampToShortest(rrect, rrect.trRadiusX));
    final double trRadiusY =
        math.max(0.0, _clampToShortest(rrect, rrect.trRadiusY));
    final double trRadius = math.min(trRadiusX, trRadiusY);
    //
    final double blRadiusX =
        math.max(0.0, _clampToShortest(rrect, rrect.blRadiusX));
    final double blRadiusY =
        math.max(0.0, _clampToShortest(rrect, rrect.blRadiusY));
    final double blRadius = math.min(blRadiusX, blRadiusY);
    //
    final double brRadiusX =
        math.max(0.0, _clampToShortest(rrect, rrect.brRadiusX));
    final double brRadiusY =
        math.max(0.0, _clampToShortest(rrect, rrect.brRadiusY));
    final double brRadius = math.min(brRadiusX, brRadiusY);

    final double minSideLength = math.min(rrect.width, rrect.height);

    double largestRadius = math.max(tlRadius, trRadius);
    largestRadius = math.max(largestRadius, blRadius);
    largestRadius = math.max(largestRadius, brRadius);

    // These equations give the x and y values for each of the 8 mid and corner
    // points on a rectangle.
    //
    // For example, leftX(k) will give the x value on the left side of the shape
    // that is precisely `k` distance from the left edge of the shape for the
    // predetermined 'limitedRadius' value.
    double leftX(double x) {
      return centerX + x * limitedRadius - width / 2;
    }

    double rightX(double x) {
      return centerX - x * limitedRadius + width / 2;
    }

    double topY(double y) {
      return centerY + y * limitedRadius - height / 2;
    }

    double bottomY(double y) {
      return centerY - y * limitedRadius + height / 2;
    }

    // Renders the default super elliptical rounded rect shape where there are
    // 4 straight edges and 4 90º corners. Approximately renders a superellipse
    // with an n value of 5.
    //
    // Paths and equations were inspired from the code listed on this website:
    // https://www.paintcodeapp.com/news/code-for-ios-7-rounded-rectangles
    //
    // The shape is drawn from the top midpoint to the upper right hand corner
    // in a clockwise fashion around to the upper left hand corner.
    Path bezierRoundedRect() {
      return Path()
        ..moveTo(leftX(1.52866483), topY(0.0))
        ..lineTo(rightX(1.52866471), topY(0.0))
        ..cubicTo(rightX(1.08849323), topY(0.0), rightX(0.86840689), topY(0.0),
            rightX(0.66993427), topY(0.06549600))
        ..lineTo(rightX(0.63149399), topY(0.07491100))
        ..cubicTo(rightX(0.37282392), topY(0.16905899), rightX(0.16906013),
            topY(0.37282401), rightX(0.07491176), topY(0.63149399))
        ..cubicTo(rightX(0), topY(0.86840701), rightX(0.0), topY(1.08849299),
            rightX(0.0), topY(1.52866483))
        ..lineTo(rightX(0.0), bottomY(1.52866471))
        ..cubicTo(rightX(0.0), bottomY(1.08849323), rightX(0.0),
            bottomY(0.86840689), rightX(0.06549600), bottomY(0.66993427))
        ..lineTo(rightX(0.07491100), bottomY(0.63149399))
        ..cubicTo(rightX(0.16905899), bottomY(0.37282392), rightX(0.37282401),
            bottomY(0.16906013), rightX(0.63149399), bottomY(0.07491176))
        ..cubicTo(rightX(0.86840701), bottomY(0), rightX(1.08849299),
            bottomY(0.0), rightX(1.52866483), bottomY(0.0))
        ..lineTo(leftX(1.52866483), bottomY(0.0))
        ..cubicTo(leftX(1.08849323), bottomY(0.0), leftX(0.86840689),
            bottomY(0.0), leftX(0.66993427), bottomY(0.06549600))
        ..lineTo(leftX(0.63149399), bottomY(0.07491100))
        ..cubicTo(leftX(0.37282392), bottomY(0.16905899), leftX(0.16906013),
            bottomY(0.37282401), leftX(0.07491176), bottomY(0.63149399))
        ..cubicTo(leftX(0), bottomY(0.86840701), leftX(0.0),
            bottomY(1.08849299), leftX(0.0), bottomY(1.52866483))
        ..lineTo(leftX(0.0), topY(1.52866471))
        ..cubicTo(leftX(0.0), topY(1.08849323), leftX(0.0), topY(0.86840689),
            leftX(0.06549600), topY(0.66993427))
        ..lineTo(leftX(0.07491100), topY(0.63149399))
        ..cubicTo(leftX(0.16905899), topY(0.37282392), leftX(0.37282401),
            topY(0.16906013), leftX(0.63149399), topY(0.07491176))
        ..cubicTo(leftX(0.86840701), topY(0), leftX(1.08849299), topY(0.0),
            leftX(1.52866483), topY(0.0))
        ..close();
    }

    // The ratio of of stadium circular border, at which this algorithm break
    // down and clips to strange TIE-fighter shapes. At this ratio the
    // borer radius is clamped.
    const double maxStadiumRatio = 0.65;

    limitedRadius =
        math.min(largestRadius, minSideLength / 2 * maxStadiumRatio);
    return bezierRoundedRect();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(
        borderRadius.resolve(textDirection).toRRect(rect).deflate(side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(borderRadius
        .resolve(textDirection)
        .toRRect(rect)
        .inflate(side.strokeOffset / 2));
  }

  @override
  SquircleBorder copyWith({
    BorderSide? side,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SquircleBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (rect.isEmpty) {
      return;
    }
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        if (side.width != 0.0) {
          canvas.drawPath(
            getOuterPath(rect, textDirection: textDirection),
            side.toPaint(),
          );
        }
    }
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    return other is SquircleBorder &&
        other.side == side &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(side, borderRadius);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'SquircleBorder')}($side, $borderRadius)';
  }
}
