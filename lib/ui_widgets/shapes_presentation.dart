import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../squircle/flex_border.dart';

class ShapesPresentation extends StatelessWidget {
  const ShapesPresentation({super.key, required this.radius});

  final double radius;

  static const double height = 120;
  static const double width = 210;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color demoShapeColor = theme.colorScheme.primaryContainer;
    final Color demoOnShapeColor = theme.colorScheme.onPrimaryContainer;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          Material(
            color: demoShapeColor,
            shape: FlexBorder.circular.shape(radius: radius),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'Circular\n'
                  'Flutter SDK',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.continuous.shape(radius: radius),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'ContinuousRectangle\n'
                  'Flutter SDK',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.continuousSquircle.shape(radius: radius),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'ContinuousRectangle\n'
                  'Flutter SDK r=r*2.3529',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.squircleBorder.shape(radius: radius),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'SquircleBorder\n'
                  'Rejected PR',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.figmaSquircle.shape(radius: radius),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'Figma Squircle\n'
                  'figma_squircle',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.smoothCorner.shape(radius: radius),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'SmoothCorner\n'
                  'smooth_corner',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.cupertinoCorners
                .shape(radius: math.min(radius, 150)),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'CupertinoSquircleBorder\n'
                  'cupertino_rounded_corners',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.superEllipse.shape(radius: radius),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'SuperEllipseShape\n'
                  'superellipse_shape',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.stadium.shape(),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'StadiumBorder\n'
                  'Flutter SDK',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.squircleStadiumBorder.shape(),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'SquircleStadiumBorder\n'
                  'Rejected PR',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.simonSquircle.shape(radius: radius),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'SimonSquircleBorder\n'
                  'slightfoot gist',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
          Material(
            color: demoShapeColor,
            shape: FlexBorder.beveled.shape(radius: radius),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: Text(
                  'BeveledRectangleBorder\n'
                  'Flutter SDK',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: demoOnShapeColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
