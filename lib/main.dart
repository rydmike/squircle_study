// MIT License
//
// Copyright (c) 2023 Mike Rydstrom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import 'package:flutter/material.dart';

import 'app/constants/app_data.dart';
import 'app/theme/theme.dart';
import 'app/widgets/about/about.dart';
import 'home/home_page.dart';

void main() {
  runApp(const SquircleDemo());
}

class SquircleDemo extends StatefulWidget {
  const SquircleDemo({super.key});

  @override
  State<SquircleDemo> createState() => _SquircleDemoState();
}

class _SquircleDemoState extends State<SquircleDemo> {
  ThemeMode themeMode = ThemeMode.light;
  ThemeSettings settings = const ThemeSettings(useMaterial3: true, customSetting: false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppData.appName,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: theme(Brightness.light, settings),
      darkTheme: theme(Brightness.dark, settings),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(AppData.appName),
          actions: <Widget>[
            const AboutIconButton(),
            IconButton(
              icon: settings.useMaterial3 ? const Icon(Icons.filter_3) : const Icon(Icons.filter_2),
              onPressed: () {
                setState(() {
                  settings = settings.copyWith(useMaterial3: !settings.useMaterial3);
                });
              },
              tooltip: 'Switch to Material ${settings.useMaterial3 ? 2 : 3}',
            ),
            IconButton(
              icon: themeMode == ThemeMode.dark
                  ? const Icon(Icons.wb_sunny_outlined)
                  : const Icon(Icons.wb_sunny),
              onPressed: () {
                setState(() {
                  if (themeMode == ThemeMode.light) {
                    themeMode = ThemeMode.dark;
                  } else {
                    themeMode = ThemeMode.light;
                  }
                });
              },
              tooltip: 'Toggle brightness',
            ),
          ],
        ),
        body: const HomePage(),
      ),
    );
  }
}
