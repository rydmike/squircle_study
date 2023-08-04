import 'package:flutter/material.dart';

import 'squircle/flex_border.dart';
import 'theme.dart';
import 'ui_widgets/flex_border_popup_menu.dart';
import 'ui_widgets/list_tile_reveal.dart';
import 'ui_widgets/show_color_scheme_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.settings,
    required this.onSettings,
  });

  final ThemeSettings settings;
  final ValueChanged<ThemeSettings> onSettings;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? isSelected1 = true;
  bool? isSelected2;
  double radius = 50;
  double heightBig = 400;
  double widthBig = 600;
  double smoothness = 0.6;
  double lineWidth = 1.0;

  FlexBorder bottomType = FlexBorder.squircleBorder;
  FlexBorder topType = FlexBorder.smoothCorner;

  static const double height = 120;
  static const double width = 210;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color demoShapeColor = theme.colorScheme.primaryContainer;
    final Color demoOnShapeColor = theme.colorScheme.onPrimaryContainer;
    //
    // Colors for the compared shapes use different vars in case we want
    // try other colors.
    // TODO(rydmike): Add color selection to UI of compared shaped.
    final Color bottomShapeColor = theme.colorScheme.primaryContainer;
    final Color bottomOnShapeColor = theme.colorScheme.onPrimaryContainer;
    final Color lineColor = theme.colorScheme.onSurface;

    return ListView(
      children: <Widget>[
        const SizedBox(height: 8),
        const ListTileReveal(
          enabled: true,
          title: Text('ShapeBorder'),
          subtitleDense: true,
          subtitle: Text(
            'By default Material UI widgets with ShapeBorder use circular '
            'corners or half-circle stadium shapes, via the ShapeBorder '
            'called RoundedRectangleBorder and StadiumBorder. '
            'You can change the used ShapeBorder type.\n'
            '\n'
            'A "Squircle" shape, is a type of super-ellipses corner shape used '
            'by Apple on iOS. This demo allows you to compare different '
            'Flutter implementations of squircle borders.\n',
          ),
        ),
        Padding(
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
                shape: FlexBorder.cupertinoCorners.shape(radius: radius),
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
        ),
        const ListTileReveal(
          enabled: true,
          title: Text('Compare two ShapeBorders'),
          subtitleDense: true,
          subtitle: Text('Select one filled and one outlined '
              'shaped to compare their shape.\n '
              'You can adjust their size and border radius.\n'),
        ),
        FlexBorderPopupMenu(
          title: const Text('FILLED'),
          type: bottomType,
          onChanged: (FlexBorder type) {
            setState(() {
              bottomType = type;
            });
          },
        ),
        FlexBorderPopupMenu(
          title: const Text('OUTLINED'),
          type: topType,
          onChanged: (FlexBorder type) {
            setState(() {
              topType = type;
            });
          },
        ),
        //
        // Adjust HEIGHT of compared shapes.
        //
        ListTile(
          title: Slider(
            min: 100,
            max: 800,
            label: heightBig.toStringAsFixed(0),
            value: heightBig,
            onChanged: (double value) {
              setState(() {
                heightBig = value;
              });
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'HEIGHT',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  heightBig.toStringAsFixed(0),
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        //
        // Adjust WIDTH of compared shapes.
        //
        ListTile(
          enabled: true,
          title: Slider(
            min: 100,
            max: 800,
            label: widthBig.toStringAsFixed(0),
            value: widthBig,
            onChanged: (double value) {
              setState(() {
                widthBig = value;
              });
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'WIDTH',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  widthBig.toStringAsFixed(0),
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        //
        // Adjust RADIUS of compared shapes.
        //
        ListTile(
          title: Slider(
            min: 0,
            max: 800,
            label: radius.toStringAsFixed(0),
            value: radius,
            onChanged: (double value) {
              setState(() {
                radius = value;
              });
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'RADIUS',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  radius.toStringAsFixed(2),
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        //
        // Draw the selected two shapes on top of each other in a stack.
        //
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Material(
                clipBehavior: Clip.hardEdge,
                color: bottomShapeColor,
                shape: bottomType.shape(radius: radius, smoothness: smoothness),
                child: SizedBox(
                  height: heightBig,
                  width: widthBig,
                  child: Center(
                    child: Text(
                      'FILLED: ${bottomType.type}\n\n'
                      'OUTLINED: ${topType.type}',
                      style: TextStyle(color: bottomOnShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                shape: topType.shape(
                  radius: radius,
                  lineWidth: lineWidth,
                  lineColor: lineColor,
                  smoothness: smoothness,
                ),
                child: SizedBox(
                  height: heightBig,
                  width: widthBig,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Slider(
            min: 0.5,
            max: 5,
            divisions: 18,
            label: lineWidth.toStringAsFixed(2),
            value: lineWidth,
            onChanged: (double value) {
              setState(() {
                lineWidth = value;
              });
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'LINE WIDTH',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  lineWidth.toStringAsFixed(2),
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        //
        // Adjust smoothness
        //
        ListTile(
          title: const Text('Smoothness\nOnly applies to FigmaSquircle and '
              'Figma SmoothCorner\n(Figma claims 0.6 = iOS)'),
          subtitle: Slider(
            min: 0,
            max: 1,
            divisions: 100,
            label: smoothness.toStringAsFixed(2),
            value: smoothness,
            onChanged: (double value) {
              setState(() {
                smoothness = value;
              });
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'SMOOTHNESS',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  smoothness.toStringAsFixed(2),
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ShowColorSchemeColors(),
        ),
      ],
    );
  }
}