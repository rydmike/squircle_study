import 'package:flutter/material.dart';

import 'squircle/flex_border.dart';
import 'theme.dart';
import 'ui_widgets/flex_border_popup_menu.dart';
import 'ui_widgets/list_tile_reveal.dart';
import 'ui_widgets/shapes_presentation.dart';
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
  double strokeAlign = -1; // -1=Inside, 0=Center, 1=Outside
  bool clipMaterial = false;
  bool fillOutline = true;

  FlexBorder filledShape = FlexBorder.circular;
  FlexBorder outlinedShape = FlexBorder.squircleBorder;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // TODO(rydmike): Consider adding color selection to UI of compared shapes.
    // Colors for the compared shapes and lines.
    final Color bottomShapeColor = theme.colorScheme.primaryContainer;
    final Color bottomOnShapeColor = theme.colorScheme.onPrimaryContainer;
    final Color lineColor = theme.colorScheme.onSurface;
    // Optional translucent fill on the shape that has the outlined border.
    final Color topShapeFillColor =
        theme.colorScheme.tertiary.withOpacity(0.15);

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
        // Present the different shapes studied.
        ShapesPresentation(radius: radius),
        //
        //
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
          type: filledShape,
          onChanged: (FlexBorder type) {
            setState(() {
              filledShape = type;
            });
          },
        ),
        FlexBorderPopupMenu(
          title: const Text('OUTLINED'),
          type: outlinedShape,
          onChanged: (FlexBorder type) {
            setState(() {
              outlinedShape = type;
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
            divisions: 800,
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
                  radius.toStringAsFixed(0),
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
                shape: filledShape.shape(
                  radius: radius,
                  smoothness: smoothness,
                ),
                child: SizedBox(
                  height: heightBig,
                  width: widthBig,
                ),
              ),
              Material(
                clipBehavior:
                    clipMaterial ? Clip.antiAliasWithSaveLayer : Clip.none,
                color: fillOutline ? topShapeFillColor : Colors.transparent,
                shape: outlinedShape.shape(
                  radius: radius,
                  lineWidth: lineWidth,
                  lineColor: lineColor,
                  smoothness: smoothness,
                  strokeAlign: strokeAlign,
                ),
                child: SizedBox(
                  height: heightBig,
                  width: widthBig,
                  child: Center(
                    child: Text(
                      'FILLED: ${filledShape.type}\n\n'
                      'OUTLINED: ${outlinedShape.type}',
                      style: TextStyle(color: bottomOnShapeColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 40),
          child: SizedBox(
            height: 60,
            child: Center(
              child: Material(
                  color: lineColor,
                  child: SizedBox(
                    height: lineWidth,
                    width: double.infinity,
                  )),
            ),
          ),
        ),
        ListTile(
          title: Slider(
            min: 0,
            max: 20,
            divisions: 80,
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
        // Adjust stroke alignment
        //
        ListTile(
          title: const Text('Border stroke align\n'
              '-1 = Inside, 0 = Center, 1 = Outside'),
          subtitle: Slider(
            min: -1,
            max: 1,
            divisions: 2,
            label: strokeAlign.toStringAsFixed(2),
            value: strokeAlign,
            onChanged: (double value) {
              setState(() {
                strokeAlign = value;
              });
            },
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'STROKE ALIGN',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  strokeAlign.toStringAsFixed(2),
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SwitchListTile(
          title: const Text("Outlined shape's Material is filled with "
              'transparent color'),
          value: fillOutline,
          onChanged: (bool value) {
            setState(() {
              fillOutline = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text("Outlined shape's Material is clipped"),
          value: clipMaterial,
          onChanged: (bool value) {
            setState(() {
              clipMaterial = value;
            });
          },
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
