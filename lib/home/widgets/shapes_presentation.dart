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
          _DrawShapeBorder(
            label: 'Circular\nFlutter SDK',
            shape: ShapeBorders.circular.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'ContinuousRectangle\nFlutter SDK',
            shape: ShapeBorders.continuous.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'ContinuousRectangle\nFlutter SDK r=r*2.3529',
            shape: ShapeBorders.continuousSquircle.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'SquircleBorder\nRejected PR',
            shape: ShapeBorders.squircleBorder.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'Figma Squircle\nfigma_squircle',
            shape: ShapeBorders.figmaSquircle.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'SmoothCorner\nsmooth_corner',
            shape: ShapeBorders.smoothCorner.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'CupertinoSquircleBorder\ncupertino_rounded_corners',
            shape: ShapeBorders.cupertinoCorners.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'SuperEllipseShape\nsuperellipse_shape',
            shape: ShapeBorders.superEllipse.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'StadiumBorder\nFlutter SDK',
            shape: ShapeBorders.stadium.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'SquircleStadiumBorder\nRejected PR',
            shape: ShapeBorders.squircleStadiumBorder.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'SimonSquircleBorder\nslightfoot gist',
            shape: ShapeBorders.simonSquircle.shape(radius: radius),
          ),
          _DrawShapeBorder(
            label: 'BeveledRectangleBorder\nFlutter SDK',
            shape: ShapeBorders.beveled.shape(radius: radius),
          ),
        ],
      ),
    );
  }
}

class _DrawShapeBorder extends StatelessWidget {
  const _DrawShapeBorder({
    super.key,
    required this.label,
    required this.shape,
  });

  final String label;
  final ShapeBorder shape;

  static const double height = 120;
  static const double width = 210;

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
