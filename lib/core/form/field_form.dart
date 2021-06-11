import 'package:flutter/foundation.dart';

enum FieldFormState {
  empty,
  error,
  valid,
}

abstract class FieldForm<T, ERR> {
  final T value;
  final FieldFormState state;
  final ERR? error;

  FieldForm({
    required this.value,
    this.state = FieldFormState.empty,
    this.error,
  });

  FieldForm<T, ERR> copyWith({
    @required T value,
    FieldFormState state,
    ERR error,
  });

  FieldForm<T, ERR> validate();

  bool valid() => this.validate().state != FieldFormState.error;

  ERR? getError() => this.state == FieldFormState.error ? this.error : null;

  FieldForm<T, ERR> setError(ERR err);
}
