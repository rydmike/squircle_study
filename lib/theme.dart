// A seed color for the M3 ColorScheme.
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const Color seedColor = Color(0xFF254783); // Color(0xFF6750A4);

final ColorScheme colorSchemeLight = SeedColorScheme.fromSeeds(
  brightness: Brightness.light,
  primaryKey: seedColor,
  tones: FlexTones.candyPop(Brightness.light),
);

final ColorScheme colorSchemeDark = SeedColorScheme.fromSeeds(
  brightness: Brightness.dark,
  primaryKey: seedColor,
  tones: FlexTones.candyPop(Brightness.dark),
);

// Example theme
ThemeData theme(Brightness brightness, ThemeSettings settings) {
  return ThemeData(
    colorScheme:
        brightness == Brightness.light ? colorSchemeLight : colorSchemeDark,
    useMaterial3: settings.useMaterial3,
    visualDensity: VisualDensity.standard,
  );
}

/// A Theme Settings class to bundle properties we want to modify on our
/// theme interactively.
@immutable
class ThemeSettings with Diagnosticable {
  final bool useMaterial3;
  final bool customCheck;
  final bool tintedInteraction;
  final bool tintedDisable;
  final bool coloredUnselected;

  const ThemeSettings({
    required this.useMaterial3,
    required this.customCheck,
    required this.tintedInteraction,
    required this.tintedDisable,
    required this.coloredUnselected,
  });

  /// Flutter debug properties override, includes toString.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('useMaterial3', useMaterial3));
    properties.add(DiagnosticsProperty<bool>('customCheckTheme', customCheck));
    properties
        .add(DiagnosticsProperty<bool>('tintedInteraction', tintedInteraction));
    properties.add(DiagnosticsProperty<bool>('tintedDisable', tintedDisable));
    properties.add(
        DiagnosticsProperty<bool>('customCheckUnselected', coloredUnselected));
  }

  /// Copy the object with one or more provided properties changed.
  ThemeSettings copyWith({
    bool? useMaterial3,
    bool? customCheck,
    bool? tintedInteraction,
    bool? tintedDisable,
    bool? coloredUnselected,
  }) {
    return ThemeSettings(
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      customCheck: customCheck ?? this.customCheck,
      tintedInteraction: tintedInteraction ?? this.tintedInteraction,
      tintedDisable: tintedDisable ?? this.tintedDisable,
      coloredUnselected: coloredUnselected ?? this.coloredUnselected,
    );
  }

  /// Override the equality operator.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ThemeSettings &&
        other.useMaterial3 == useMaterial3 &&
        other.customCheck == customCheck &&
        other.tintedInteraction == tintedInteraction &&
        other.tintedDisable == tintedDisable &&
        other.coloredUnselected == coloredUnselected;
  }

  /// Override for hashcode, dart.ui Jenkins based.
  @override
  int get hashCode => Object.hashAll(<Object?>[
        useMaterial3.hashCode,
        customCheck.hashCode,
        tintedInteraction.hashCode,
        tintedDisable.hashCode,
        coloredUnselected.hashCode,
      ]);
}
