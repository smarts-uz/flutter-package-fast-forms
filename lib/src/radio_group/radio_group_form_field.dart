import 'package:flutter/material.dart';

import '../radio_group/radio_group.dart';

typedef RadioOptionsBuilder = Widget Function(BuildContext context,
    List<RadioOption> options, RadioGroupFormFieldState state);

enum RadioGroupOrientation {
  horizontal,
  vertical,
}

class RadioGroupFormField<T> extends FormField<T> {
  RadioGroupFormField({
    bool autovalidate,
    InputDecoration decoration = const InputDecoration(),
    Key key,
    @required this.options,
    this.orientation = RadioGroupOrientation.vertical,
    this.onChanged,
    this.onReset,
    this.optionsBuilder,
    FormFieldSetter onSaved,
    FormFieldValidator validator,
    T value,
  })  : assert(decoration != null),
        super(
          autovalidate: autovalidate,
          builder: (field) {
            final state = field as RadioGroupFormFieldState;
            final InputDecoration effectiveDecoration = decoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);
            final _optionsBuilder = optionsBuilder ?? radioOptionsBuilder;
            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: state.errorText,
              ),
              child: _optionsBuilder(state.context, options, state),
            );
          },
          initialValue: value ?? options.first.value,
          key: key,
          onSaved: onSaved,
          validator: validator,
        );

  final ValueChanged onChanged;
  final VoidCallback onReset;
  final List<RadioOption<T>> options;
  final RadioOptionsBuilder optionsBuilder;
  final RadioGroupOrientation orientation;

  @override
  FormFieldState<T> createState() => RadioGroupFormFieldState<T>();
}

class RadioGroupFormFieldState<T> extends FormFieldState<T> {
  @override
  RadioGroupFormField<T> get widget => super.widget;

  @override
  void didChange(T value) {
    super.didChange(value);
    widget.onChanged?.call(value);
  }

  @override
  void reset() {
    super.reset();
    widget.onReset?.call();
  }
}

final RadioOptionsBuilder radioOptionsBuilder =
    (BuildContext context, options, RadioGroupFormFieldState state) {
  final vertical = state.widget.orientation == RadioGroupOrientation.vertical;
  final _tiles = options.map((option) {
    final tile = RadioListTile(
      title: Text(option.title),
      value: option.value,
      groupValue: state.value,
      onChanged: state.didChange,
    );
    return vertical ? tile : Expanded(child: tile);
  }).toList();

  return vertical ? Column(children: _tiles) : Row(children: _tiles);
};
