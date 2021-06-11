import 'package:nane_chat/core/form/field_form.dart';

class UsernameField extends FieldForm<String, String> {
  UsernameField({
    String value = "",
    FieldFormState state = FieldFormState.empty,
    String? error,
  }) : super(
          value: value,
          state: state,
          error: error,
        );

  @override
  UsernameField copyWith({String? value, FieldFormState? state, String? error}) {
    return UsernameField(
      value: value ?? this.value,
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }

  @override
  UsernameField setError(String err) {
    return copyWith(
      error: err,
      state: FieldFormState.error,
    );
  }

  @override
  UsernameField validate() {
    return copyWith(
      state: FieldFormState.valid,
    );
  }
}
