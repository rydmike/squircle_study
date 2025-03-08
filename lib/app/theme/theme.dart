// A seed color for the M3 ColorScheme.
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color seedColor = Color(0xFF254783);

final ColorScheme colorSchemeLight = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: seedColor,
  tones: FlexTones.oneHue(Brightness.light),
);

final ColorScheme colorSchemeDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: seedColor,
  tones: FlexTones.oneHue(Brightness.dark),
);

/// No need for a fancy theme for this app, M3 looks good out of the box.
ThemeData theme(Brightness brightness, ThemeSettings settings) {
  return ThemeData(
    colorScheme: brightness == Brightness.light ? colorSchemeLight : colorSchemeDark,
    useMaterial3: settings.useMaterial3,
    visualDensity: VisualDensity.standard,
  );
}

/// A Theme Settings class to bundle properties we want to modify in our
/// theme interactively.
///
/// Not really used for anything except the M2/M3 toggle in this app so far,
/// plus a stub for an additional setting.
@immutable
class ThemeSettings with Diagnosticable {
  const ThemeSettings({required this.useMaterial3, required this.customSetting});
  final bool useMaterial3;
  final bool customSetting;

  /// Flutter debug properties override, includes toString.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('useMaterial3', useMaterial3));
    properties.add(DiagnosticsProperty<bool>('customSetting', customSetting));
  }

  /// Copy the object with one or more provided properties changed.
  ThemeSettings copyWith({bool? useMaterial3, bool? customSetting}) {
    return ThemeSettings(
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      customSetting: customSetting ?? this.customSetting,
    );
  }

  /// Override the equality operator.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ThemeSettings &&
        other.useMaterial3 == useMaterial3 &&
        other.customSetting == customSetting;
  }

  /// Override for hashcode.
  @override
  int get hashCode => Object.hashAll(<Object?>[useMaterial3.hashCode, customSetting.hashCode]);
}
