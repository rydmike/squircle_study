import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/app_data.dart';
import '../../utils/flex_color_extension.dart';
import 'copy_color_to_clipboard.dart';

/// This is just simple SizedBox in a Card, with a passed in label, background
/// and text label color. Used to show the colors of a theme or scheme
/// color property.
///
/// It also has a tooltip to show the color code, its Material name, if it
/// is a Material 2 color, and it always shows its general/common name, from
/// a list of +1600 color names.
///
/// When you tap the ColorCard the color value is copied to the clipboard
/// in Dart format.
class ColorCard extends StatelessWidget {
  const ColorCard({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
    this.size,
  });

  final String label;
  final Color color;
  final Color textColor;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final bool isPhone =
        media.size.width < AppData.phoneWidthBreakpoint ||
        media.size.height < AppData.phoneHeightBreakpoint;
    final double fontSize = isPhone ? 10 : 11;
    final Size effectiveSize = size ?? (isPhone ? const Size(74, 54) : const Size(86, 58));

    return SizedBox(
      width: effectiveSize.width,
      height: effectiveSize.height,
      child: Tooltip(
        waitDuration: const Duration(milliseconds: 700),
        message:
            color != textColor
                ? 'Color #${color.hexCode}.'
                    '\nTap box to copy RGB value to Clipboard.'
                : '',
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          color: color,
          child: InkWell(
            onTap:
                color != textColor
                    ? () {
                      unawaited(copyColorToClipboard(context, color));
                    }
                    : null,
            child: Center(
              child: Text(
                label,
                style: TextStyle(color: textColor, fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
