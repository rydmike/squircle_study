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
  double heightBig = 160;
  double widthBig = 320;
  double smoothness = 0.6;

  FlexBorder bottomType = FlexBorder.figmaSquircle;
  FlexBorder topType = FlexBorder.smoothCorner;

  static const double height = 100;
  static const double width = 210;
  static const double lineWidth = 1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final Color shapeColor = isLight
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.primaryContainer;
    final Color lineColor = theme.colorScheme.error;
    final Color onShapeColor = theme.colorScheme.onPrimaryContainer;

    return ListView(
      children: <Widget>[
        const SizedBox(height: 8),
        // SwitchListTile(
        //   title: const Text('Enable custom Checkbox theme'),
        //   value: widget.settings.customCheck,
        //   onChanged: (bool value) {
        //     widget.onSettings(widget.settings.copyWith(customCheck: value));
        //   },
        // ),
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
            'by Apple on iOS. This is supported via custom SquircleBorder and '
            'SquircleStadiumBorder implementations. If Flutter SDK at some '
            'point starts supporting a version of this shape, it will be '
            'supported as well. This custom implementation may then later be '
            'deprecated if the shapes are identical or very close. The '
            'custom version will be kept around for many version in parallel.\n'
            '\n'
            'You can also use an alternative corner ShapeBorder in Flutter, '
            'called ContinuousRectangleBorder. It was originally added '
            'in Flutter to provide a Squircle implementation in, but it is '
            'a very poor match for the version used by Apple on iOS. If you '
            'multiply used border radius with 2.35, it becomes a closer match, '
            'but not exactly.\n'
            '\n'
            'A beveled shape BeveledRectangleBorder, is also available.\n'
            '\n'
            'You could use the Circular shape as default main shape, and '
            'e.g. on iOS and macOS use the Squircle shape.\n',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.circular.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'Circular\n'
                      'Flutter SDK',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.continuousSquircle.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'ContinuousRectangle\n'
                      'Flutter SDK r=r*2.3529',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.squircle.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'Squircle\n'
                      'Rejected PR',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.figmaSquircle.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'Figma Squircle\n'
                      'figma_squircle',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.smoothCorner.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'SmoothCorner\n'
                      'smooth_corner',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.continuous.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'ContinuousRectangle\n'
                      'Flutter SDK',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAlias,
                color: shapeColor,
                shape: FlexBorder.cupertinoCorners.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'SquircleBorder\n'
                      'cupertino_rounded_corners',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.superEllipse.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'SuperEllipseShape\n'
                      'superellipse_shape',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.stadium.shape(),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'StadiumBorder\n'
                      'Flutter SDK',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.squircleStadium.shape(),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'SquircleStadiumBorder\n'
                      'Rejected PR',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.simonSquircle.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'SimonSquircleBorder\n'
                      'slightfoot gist',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: FlexBorder.beveled.shape(radius: radius),
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Center(
                    child: Text(
                      'BeveledRectangleBorder\n'
                      'Flutter SDK',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: onShapeColor),
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
          subtitle: Text(
            'By default, the border radius on all Material '
            'UI components in FCS follow the Material-3 design guide in M3 '
            'mode. The defaults used by FCS for M2 mode, are also mostly M3 '
            'inspired.\n'
            '\n'
            'Radius specification in M3 varies per component. '
            'Material 2 specification used 4 dp on all components. To use M2 '
            'specification, set this value to 4. '
            'If you set a value, all major Material UI components will use '
            'it as their border radius. You can also set radius per '
            'component, they will then use their own value, regardless of '
            'what is defined here.\n'
            '\n'
            'Radius on very small elements, or components where changing it '
            'to a high radius is a bad idea, are not included in this global '
            'radius override. This includes PopupMenuButton, Menu, '
            'MenuBar, SubmenuButton, MenuItemButton, ToolTip, the small '
            'indicators on NavigationBar and '
            'NavigationRail, as well as the SnackBar. The very distinct '
            'FloatingActionButton can be included, but is not by default. '
            'The radius on these elements can still be themed, but only '
            'individually. The indicator on NavigationDrawer is button sized '
            'and considered large, it is thus included in the global border '
            'radius override.',
          ),
        ),

        FlexBorderPopupMenu(
          title: const Text('Background ShapeBorder'),
          type: bottomType,
          onChanged: (FlexBorder type) {
            setState(() {
              bottomType = type;
            });
          },
        ),

        FlexBorderPopupMenu(
          title: const Text('Foreground Outline ShapeBorder'),
          type: topType,
          onChanged: (FlexBorder type) {
            setState(() {
              topType = type;
            });
          },
        ),
        ListTile(
          title: Slider(
            min: 100,
            max: 500,
            // divisions: 100,
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
        ListTile(
          enabled: true,
          title: Slider(
            min: 100,
            max: 500,
            // divisions: 100,
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
        ListTile(
          title: Slider(
            min: 0,
            max: 500,
            // divisions: 100,
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
        ListTile(
          title: Slider(
            min: 0,
            max: 1,
            // divisions: 100,
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: shapeColor,
                shape: bottomType.shape(radius: radius),
                child: SizedBox(
                  height: heightBig,
                  width: widthBig,
                  child: Center(
                    child: Text(
                      'Background: ${bottomType.type}\n'
                      'Outline: ${topType.type}',
                      style: TextStyle(color: onShapeColor),
                    ),
                  ),
                ),
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
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
