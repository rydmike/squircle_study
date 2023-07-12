import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart'
    as cuper;
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart' as smooth;
import 'package:superellipse_shape/superellipse_shape.dart';

import 'flex_squircle.dart';
import 'flex_stadium_squircle.dart';
import 'simon_squircle.dart';

enum FlexBorder {
  circular(
    type: 'Circular',
    shortName: 'RoundedRectangleBorder',
    from: 'Flutter SDK',
    url:
        'https://api.flutter.dev/flutter/painting/RoundedRectangleBorder-class.html',
    describe: 'The standard circular rounded rectangle border shape with an '
        'outline provided by Flutter.',
    icon: Icons.rectangle_rounded,
  ),
  continuousSquircle(
    type: 'ContinuousSquircle',
    shortName: 'ContinuousRectangleBorder x 2.3529',
    from: 'Flutter SDK x factor',
    url:
        'https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html',
    describe: 'The Flutter continuous rounded rounded rectangle border shape '
        'using radius multiplied with 2.3529.',
    icon: Icons.rectangle_rounded,
  ),
  squircle(
    type: 'Squircle PR',
    shortName: 'SquircleBorder',
    from: 'Flutter rejected PR',
    url:
        'https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_rectangle_border.dart',
    describe: 'A PR for a Squircle that was rejected in Flutter SDK. It was '
        'discussed here https://github.com/flutter/flutter/pull/27523. '
        'This is a RydMike code revival of the PR with some mods.',
    icon: Icons.rectangle_rounded,
  ),
  figmaSquircle(
    type: 'FigmaSquircle',
    shortName: 'SmoothRectangleBorder',
    from: 'package figma_squircle',
    url: 'https://pub.dev/packages/figma_squircle',
    describe: 'A Flutter package implementation of Figma corner smoothing.',
    icon: Icons.rectangle_rounded,
  ),
  smoothCorner(
    type: 'SmoothCorner',
    shortName: 'SmoothRectangleBorder',
    from: 'package smooth_corner',
    url: 'https://pub.dev/packages/smooth_corner',
    describe: 'A rectangular border with variable smoothness imitated '
        'from Figma.',
    icon: Icons.rectangle_rounded,
  ),
  continuous(
    type: 'Continuous',
    shortName: 'ContinuousRectangleBorder',
    from: 'Flutter SDK',
    url:
        'https://api.flutter.dev/flutter/painting/ContinuousRectangleBorder-class.html',
    describe: 'The continuous rounded rounded rectangle border shape with an '
        'outline provided by Flutter.',
    icon: Icons.rectangle_rounded,
  ),
  cupertinoCorners(
    type: 'Cupertino Corners',
    shortName: 'Cupertino SquircleBorder',
    from: 'Package: cupertino_rounded_corners',
    url: 'https://pub.dev/packages/cupertino_rounded_corners',
    describe: 'A widget and border to make cupertino rounded corners also '
        'referred to as squircles using a bezier path and having the two '
        'points in the corners.',
    icon: Icons.rectangle_rounded,
  ),
  superEllipse(
    type: 'Super Ellipse',
    shortName: 'SuperellipseShape',
    from: 'package superellipse_shape',
    url: 'https://pub.dev/packages/superellipse_shape',
    describe: 'A package for creating superellipse shapes in flutter. '
        'A superellipse is a shape constituting a transition '
        'between a rectangle and a circle.',
    icon: Icons.rectangle_rounded,
  ),
  stadium(
    type: 'StadiumBorder',
    shortName: 'StadiumBorder',
    from: 'Flutter SDK',
    url: 'https://api.flutter.dev/flutter/painting/StadiumBorder-class.html',
    describe: 'The Flutter standard circular stadium border, it fits a '
        'stadium-shaped border, a box with semicircles on the ends, within '
        'the rectangle of the widget it is applied to.',
    icon: Icons.rectangle_rounded,
  ),
  squircleStadium(
    type: 'SquircleStadium',
    shortName: 'SquircleStadiumBorder',
    from: 'Flutter rejected PR',
    url:
        'https://github.com/jslavitz/flutter/blob/4b2d32f9ebb1192bce695927cc3cab13e94cce39/packages/flutter/lib/src/painting/continuous_stadium_border.dart',
    describe: 'A PR for a Stadium Squircle that was rejected in Flutter SDK. '
        'It was discussed here https://github.com/flutter/flutter/pull/27523. '
        'This is a RydMike code revival of the PR with some mods.',
    icon: Icons.rectangle_rounded,
  ),
  simonSquircle(
    type: 'SimonSquircle',
    shortName: 'SimonSquircleBorder',
    from: 'slightfoot gist',
    url: 'https://gist.github.com/slightfoot/e35e8d5877371417e9803143e2501b0a',
    describe: 'A squircle implementation by Simon Lightfoot provided in '
        'a Gist.',
    icon: Icons.rectangle_rounded,
  ),
  beveled(
    type: 'Beveled',
    shortName: 'BeveledRectangleBorder',
    from: 'Flutter SDK',
    url:
        'https://api.flutter.dev/flutter/painting/BeveledRectangleBorder-class.html',
    describe: 'A rectangular border with flattened or "beveled" corners.',
    icon: Icons.rectangle_rounded,
  ),
  ;

  const FlexBorder({
    required this.type,
    required this.shortName,
    required this.from,
    required this.url,
    required this.describe,
    required this.icon,
  });

  final String type;
  final String shortName;
  final String from;
  final String url;
  final String describe;
  final IconData icon;

  ShapeBorder shape({
    double radius = 0,
    double lineWidth = 0,
    Color lineColor = const Color(0xFFF44336),
    double smoothness = 0.6,
  }) {
    switch (this) {
      case FlexBorder.circular:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
      case FlexBorder.continuous:
        return ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
      case FlexBorder.continuousSquircle:
        return ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius * 2.3529)),
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
      case FlexBorder.squircle:
        return SquircleBorder(cornerRadius: radius);
      case FlexBorder.figmaSquircle:
        return SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: radius,
            cornerSmoothing: smoothness,
          ),
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
      case FlexBorder.smoothCorner:
        return smooth.SmoothRectangleBorder(
          smoothness: smoothness,
          borderRadius: BorderRadius.circular(radius),
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
      case FlexBorder.cupertinoCorners:
        return cuper.SquircleBorder(
          radius: BorderRadius.all(Radius.circular(radius)),
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
      case FlexBorder.superEllipse:
        return SuperellipseShape(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
      case FlexBorder.stadium:
        return StadiumBorder(
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
      case FlexBorder.squircleStadium:
        return const SquircleStadiumBorder(
            // side: lineWidth > 0
            //     ? BorderSide(width: lineWidth, color: lineColor)
            //     : BorderSide.none,
            );
      case FlexBorder.simonSquircle:
        return SimonSquircleBorder(
          radius: radius, //.clamp(1.0, radius),
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
      case FlexBorder.beveled:
        return BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          side: lineWidth > 0
              ? BorderSide(width: lineWidth, color: lineColor)
              : BorderSide.none,
        );
    }
  }
}
