import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// App static functions and constants used in the example applications.
abstract final class AppData {
  // Returns the title of the MaterialApp. Used to set title on pages to
  // same one that is defined in each example as its app name. Handy as we only
  // need to update in one place, where it belongs and no need to put it as
  // a const somewhere and no need to pass it around via a title prop either.
  // Also used in the About box as app name.
  static String title(BuildContext context) =>
      (context as Element).findAncestorWidgetOfExactType<MaterialApp>()!.title ?? '';

  // When building new public web versions of the demos, make sure to
  // update this info before triggering GitHub actions CI/CD that builds them.
  //
  // The name of the package this app demonstrates.
  static const String appName = 'Squircle Study';
  static const String shortAppName = 'SQS';

  // Version of the WEB build, usually same as package, but it also has a
  // build numbers.
  static const String versionMajor = '1';
  static const String versionMinor = '4';
  static const String versionPatch = '1';
  static const String versionBuild = '01';
  static const String version =
      '$versionMajor.$versionMinor.$versionPatch '
      'Build-$versionBuild';

  // Check if this is a Web-WASM build, Web-JS build or native VM build.
  static const bool isRunningWithWasm = bool.fromEnvironment('dart.tool.dart2wasm');
  static const String buildType = isRunningWithWasm
      ? ', WasmGC'
      : kIsWeb
      ? ', JS'
      : ', native VM';

  static const String packageVersion = '$versionMajor.$versionMinor.$versionPatch';
  static const String flutterVersionNum = FlutterVersion.version ?? '';
  static const String flutterChannel = FlutterVersion.channel ?? '';
  static const String flutterVersion = '$flutterChannel $flutterVersionNum (canvaskit$buildType)';
  static const String copyright = '© 2025';
  static const String author = 'Mike Rydstrom';
  static const String license = 'MIT License';

  // The minimum media width treated as a phone device in this demo.
  static const double phoneWidthBreakpoint = 600;
  // The minimum media height treated as a phone device in this demo.
  static const double phoneHeightBreakpoint = 700;
}
