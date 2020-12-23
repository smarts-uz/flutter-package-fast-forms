import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart';

void main() {
  testWidgets('renders FastCheckbox', (WidgetTester tester) async {
    final helper = 'helper';
    final label = 'label';
    final title = 'title';

    await tester.pumpWidget(getFastTestWidget(
      FastCheckbox(
        id: 'checkbox',
        helper: helper,
        label: label,
        title: title,
      ),
    ));

    final fastCheckboxFinder = find.byType(FastCheckbox);
    final checkboxListTileFinder = find.byType(CheckboxListTile);

    expect(fastCheckboxFinder, findsOneWidget);
    expect(checkboxListTileFinder, findsOneWidget);

    final helperFinder = find.text(helper);
    final labelFinder = find.text(label);
    final titleFinder = find.text(title);

    expect(helperFinder, findsOneWidget);
    expect(labelFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('updates FastCheckbox', (WidgetTester tester) async {
    await tester.pumpWidget(getFastTestWidget(
      FastCheckbox(
        id: 'checkbox',
        title: 'title',
      ),
    ));

    final fastCheckboxFinder = find.byType(FastCheckbox);
    final widget = tester.widget(fastCheckboxFinder) as FastCheckbox;
    final state = tester.state(fastCheckboxFinder) as FastCheckboxState;

    expect(state.value, widget.initialValue);

    final checkboxListTileFinder = find.byType(CheckboxListTile);

    await tester.tap(checkboxListTileFinder);
    await tester.pumpAndSettle();

    expect(state.value, !widget.initialValue);
  });

  testWidgets('validates FastCheckbox', (WidgetTester tester) async {
    final errorText = 'Must be checked';

    await tester.pumpWidget(getFastTestWidget(
      FastCheckbox(
        id: 'checkbox',
        title: 'title',
        initialValue: true,
        validator: (value) => value ? null : errorText,
      ),
    ));

    final fastCheckboxFinder = find.byType(FastCheckbox);
    final state = tester.state(fastCheckboxFinder) as FastCheckboxState;

    final errorTextFinder = find.text(errorText);
    expect(errorTextFinder, findsNothing);

    state.didChange(false);
    await tester.pumpAndSettle();

    expect(errorTextFinder, findsOneWidget);
  });
}