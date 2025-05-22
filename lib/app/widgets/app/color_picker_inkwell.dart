import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

/// An [InkWell] that when tapped shows [ColorPicker.showPickerDialog] when
/// tapped.
///
/// It uses a stateless color InkWell. Clicking on it allows the user to
/// change the color using the [ColorPicker] package with its built-in dialog.
///
/// The widget has an onChanged callback that can be used to follow the changes
/// of the color in the dialog as user tries different colors.
///
/// If the users closes the dialog via cancel or barrier dismiss, the
/// wasCancelled returns true.
/// This widget is stateless so it will be up to the user of this
/// widget to hold state and return the color to the state it had
/// when dialog was opened, if so desired.
///
/// This picker is implemented this way so that we can get the selected
/// color via a callback and use the received color to change the theme of
/// the application and allow it to rebuild the theme of the entire app and the
/// screens of the context that opened the dialog. Since the dialog is stateless
/// it can be kept open even though the app under it is being rebuilt.
/// It on purpose uses its stale context and can stay open, however any color
/// theme changes will only apply to a new dialog, it will not affect the open
/// dialog itself. The application and widgets visible below the dialog is
/// however changing as colors are manipulated from the color picker dialog.
class ColorPickerInkWellDialog extends StatelessWidget {
  const ColorPickerInkWellDialog({
    super.key,
    required this.color,
    required this.onChanged,
    this.onHover,
    required this.wasCancelled,
    required this.recentColors,
    required this.onRecentColorsChanged,
    this.pickerSize = 40,
    this.enabled = false,
    required this.child,
  });

  final Color color;
  final ValueChanged<Color> onChanged;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool> wasCancelled;
  final List<Color> recentColors;
  final ValueChanged<List<Color>>? onRecentColorsChanged;

  final double pickerSize;
  final bool enabled;
  final Widget child;

  // Some example custom colors for our custom picker.
  static const Color guideNewPrimary = Color(0xFF6200EE);
  static const Color guideNewPrimaryVariant = Color(0xFF3700B3);
  static const Color guideNewSecondary = Color(0xFF03DAC6);
  static const Color guideNewSecondaryVariant = Color(0xFF018786);
  static const Color guideNewError = Color(0xFFB00020);
  static const Color guideNewErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);
  static const Color clearBlue = Color(0xFF3db5e0);
  static const Color darkPink = Color(0xFFa33e94);
  static const Color redWine = Color(0xFFad0c1c);
  static const Color grassGreen = Color(0xFF3bb87f);
  static const Color moneyGreen = Color(0xFF869962);
  static const Color mandarinOrange = Color(0xFFdb7a25);
  static const Color brightOrange = Color(0xFFff5319);
  static const Color brightGreen = Color(0xFF00ab25);
  static const Color blueJean = Color(0xFF4f75b8);
  static const Color deepBlueSea = Color(0xFF132b80);

  // Add a custom white to black grey scale.
  static const MaterialColor whiteToBlack = MaterialColor(
    0xFF7C7D80, // Set the 500 index value here.
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFE1E2E4),
      200: Color(0xFFC7C8CA),
      300: Color(0xFFACADB0),
      400: Color(0xFF949599),
      500: Color(0xFF7C7D80),
      600: Color(0xFF646567),
      700: Color(0xFF48484A),
      800: Color(0xFF212121),
      900: Color(0xFF000000),
    },
  );

  // Add a custom white to black grey scale.
  static const MaterialColor whiteBlueBlack = MaterialColor(
    0xFF4355B9, // Set the 500 index value here.
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFF0EFFF),
      200: Color(0xFFBAC3FF),
      300: Color(0xFF7789F0),
      400: Color(0xFF5D6FD4),
      500: Color(0xFF4355B9),
      600: Color(0xFF293CA0),
      700: Color(0xFF08218A),
      800: Color(0xFF00105C),
      900: Color(0xFF000000),
    },
  );

  // Custom colors
  static final Map<ColorSwatch<Object>, String> _customSwatches = <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guideNewPrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guideNewPrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideNewSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideNewSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideNewError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideNewErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
    ColorTools.createPrimarySwatch(clearBlue): 'Clear blue',
    ColorTools.createPrimarySwatch(darkPink): 'Dark pink',
    ColorTools.createPrimarySwatch(redWine): 'Red wine',
    ColorTools.createPrimarySwatch(grassGreen): 'Grass green',
    ColorTools.createPrimarySwatch(moneyGreen): 'Money green',
    ColorTools.createPrimarySwatch(mandarinOrange): 'Mandarin orange',
    ColorTools.createPrimarySwatch(brightOrange): 'Bright orange',
    ColorTools.createPrimarySwatch(brightGreen): 'Bright green',
    ColorTools.createPrimarySwatch(blueJean): 'Washed jean blue',
    ColorTools.createPrimarySwatch(deepBlueSea): 'Deep blue sea',
    whiteBlueBlack: 'White via Blue to Black',
    whiteToBlack: 'White to black',
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Make the picker using current theme, this will not change after
    // the picker dialog is opened.
    final ColorPicker colorPicker = ColorPicker(
      color: color,
      onColorChanged: onChanged,
      crossAxisAlignment: CrossAxisAlignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      enableShadesSelection: true,
      enableTonalPalette: true,
      width: 35,
      height: 35,
      spacing: 2,
      runSpacing: 2,
      elevation: 0,
      hasBorder: false,
      borderRadius: 4,
      wheelDiameter: 195,
      wheelHasBorder: false,
      wheelSquareBorderRadius: 6,
      wheelSquarePadding: 4,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      pickerTypeLabels: const <ColorPickerType, String>{
        ColorPickerType.primary: 'Primary',
        ColorPickerType.accent: 'Accent',
        ColorPickerType.bw: 'B&W',
        ColorPickerType.both: 'Both',
        ColorPickerType.custom: 'Custom',
        ColorPickerType.wheel: 'Any',
      },
      maxRecentColors: 9,
      recentColors: recentColors,
      onRecentColorsChanged: onRecentColorsChanged,
      title: Text('Select Color', style: theme.textTheme.titleLarge),
      subheading: Text('Select color shade', style: theme.textTheme.bodyLarge),
      wheelSubheading: Text('Selected color and its shades', style: theme.textTheme.bodyLarge),
      recentColorsSubheading: Text('Recent colors', style: theme.textTheme.bodyLarge),
      selectedPickerTypeColor: theme.colorScheme.primary,
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      colorCodeHasColor: true,
      customColorSwatchesAndNames: ColorPickerInkWellDialog._customSwatches,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
        editUsesParsedPaste: true,
        copyButton: true,
        pasteButton: true,
        copyFormat: ColorPickerCopyFormat.dartCode,
      ),
      actionButtons: const ColorPickerActionButtons(
        closeButton: true,
        okButton: true,
        dialogActionButtons: false,
        closeTooltipIsClose: false,
      ),
      showRecentColors: true,
    );

    return InkWell(
      onHover: (bool value) {
        onHover?.call(value);
      },
      hoverColor: Colors.transparent,
      onTap: enabled
          ? () async {
              if (await colorPicker.showPickerDialog(
                context,
                insetPadding: const EdgeInsets.all(16),
                barrierColor: Colors.black.withValues(alpha: 0.05),
                constraints: const BoxConstraints(minHeight: 570, minWidth: 450, maxWidth: 450),
              )) {
                wasCancelled(false);
              } else {
                wasCancelled(true);
              }
            }
          : null,
      child: child,
    );
  }
}
