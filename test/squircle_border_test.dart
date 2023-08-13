// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// These are the original test for the rejected PR.
// Only updated to use borderRadius and null safety version. The tests needs
// to be reviewed and revised, but they are a good starting point.

import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:squircle_study/squircle/squircle_border.dart';

void main() {
  test('Continuous rectangle border scale and lerp', () {
    const SquircleBorder c10 =
        SquircleBorder(borderRadius: BorderRadius.all(Radius.circular(100)));
    const SquircleBorder c15 =
        SquircleBorder(borderRadius: BorderRadius.all(Radius.circular(150)));
    const SquircleBorder c20 =
        SquircleBorder(borderRadius: BorderRadius.all(Radius.circular(200)));
    expect(c10.dimensions, EdgeInsets.zero);
    expect(c10.scale(2.0), c20);
    expect(c20.scale(0.5), c10);
    expect(ShapeBorder.lerp(c10, c20, 0.0), c10);
    expect(ShapeBorder.lerp(c10, c20, 0.5), c15);
    expect(ShapeBorder.lerp(c10, c20, 1.0), c20);
  });

  testWidgets('Golden test medium sized rectangle, medium radius',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RepaintBoundary(
        child: Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.blueAccent[400],
            shape: const SquircleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28)),
            ),
            child: const SizedBox(
              height: 100,
              width: 100,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(RepaintBoundary),
      matchesGoldenFile(
          'continuous_rectangle_border.golden_test_medium_medium.png'),
      skip: !Platform.isLinux,
    );
  });

  testWidgets('Golden test small sized rectangle, medium radius',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RepaintBoundary(
        child: Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.blueAccent[400],
            shape: const SquircleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28)),
            ),
            child: const SizedBox(
              height: 10,
              width: 100,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(RepaintBoundary),
      matchesGoldenFile(
          'continuous_rectangle_border.golden_test_small_medium.png'),
      skip: !Platform.isLinux,
    );
  });

  testWidgets('Golden test very small rectangle, medium radius',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RepaintBoundary(
        child: Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.blueAccent[400],
            shape: const SquircleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28)),
            ),
            child: const SizedBox(
              height: 5,
              width: 100,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(RepaintBoundary),
      matchesGoldenFile(
          'continuous_rectangle_border.golden_test_vsmall_medium.png'),
      skip: !Platform.isLinux,
    );
  });

  testWidgets('Golden test large rectangle, large radius',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      RepaintBoundary(
        child: Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.blueAccent[400],
            shape: const SquircleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: const SizedBox(
              height: 300,
              width: 300,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(RepaintBoundary),
      matchesGoldenFile(
          'continuous_rectangle_border.golden_test_large_large.png'),
      skip: !Platform.isLinux,
    );
  });
}
