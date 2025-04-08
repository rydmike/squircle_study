import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/models/shape_borders.dart';

class ShapesPresentation extends StatelessWidget {
  const ShapesPresentation({super.key, required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          DrawShapeBorder(
            label: 'Circular\nFlutter SDK',
            shape: ShapeBorders.circular.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'RoundedSuperEllipse\nFlutter SDK\nNEW in MASTER',
            shape: ShapeBorders.roundedSuperellipseBorder.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'ContinuousRectangle\nFlutter SDK',
            shape: ShapeBorders.continuous.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'ContinuousRectangle\nFlutter SDK r=r*2.3529',
            shape: ShapeBorders.continuousSquircle.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'SquircleBorder\nRejected PR',
            shape: ShapeBorders.squircleBorder.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'Figma Squircle\nfigma_squircle',
            shape: ShapeBorders.figmaSquircle.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'SmoothCorner\nsmooth_corner',
            shape: ShapeBorders.smoothCorner.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'CupertinoSquircleBorder\ncupertino_rounded_corners',
            shape: ShapeBorders.cupertinoCorners.shape(radius: math.min(radius, 150)),
          ),
          DrawShapeBorder(
            label: 'SuperEllipseShape\nsuperellipse_shape',
            shape: ShapeBorders.superEllipse.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'StadiumBorder\nFlutter SDK',
            shape: ShapeBorders.stadium.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'SquircleStadiumBorder\nRejected PR',
            shape: ShapeBorders.squircleStadiumBorder.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'SimonSquircleBorder\nslightfoot gist',
            shape: ShapeBorders.simonSquircle.shape(radius: radius),
          ),
          DrawShapeBorder(
            label: 'BeveledRectangleBorder\nFlutter SDK',
            shape: ShapeBorders.beveled.shape(radius: radius),
          ),
        ],
      ),
    );
  }
}

class DrawShapeBorder extends StatelessWidget {
  const DrawShapeBorder({super.key, required this.label, required this.shape});

  final String label;
  final ShapeBorder shape;

  static const double height = 160;
  static const double width = 280;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color demoShapeColor = theme.colorScheme.primaryContainer;
    final Color demoOnShapeColor = theme.colorScheme.onPrimaryContainer;

    return Material(
      color: demoShapeColor,
      shape: shape,
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: demoOnShapeColor),
          ),
        ),
      ),
    );
  }
}
