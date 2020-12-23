import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('FastRangeSlider', (WidgetTester tester) async {
    await tester.pumpWidget(getFastTestWidget(
      FastRangeSlider(
        id: 'range_slider',
        max: 10,
        min: 0,
      ),
    ));

    final formFieldFinder = find.byType(RangeSlider);

    expect(formFieldFinder, findsOneWidget);
  });
}
