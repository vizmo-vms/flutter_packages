import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CheckinField {
  String id;
  String label;
  String type;
  bool required;
  bool? hide = false;
  String? inputType;
  List<Option>? options;
  String? value;
  ParseFile? file;

  CheckinField({
    required this.id,
    required this.label,
    required this.type,
    required this.required,
    this.hide,
    this.inputType,
    this.options,
    this.value,
    this.file,
  });

// TODO: make type and input type as enums
// inputType: z.enum(['text', 'number', 'email', 'phone', 'date', 'any']).optional(),
//   type: z.enum(['text_field', 'single_choice', 'multi_choice', 'dropdown', 'file']),
  factory CheckinField.fromMap(
      {String? id, Map<String, dynamic> fieldMap: const {}}) {
    final _field = CheckinField(
      id: id ?? fieldMap['id'],
      label: fieldMap['label'],
      type: fieldMap['type'],
      required: fieldMap['required'],
      hide: fieldMap['hide'] ?? false,
      inputType: fieldMap['inputType'],
      options: (fieldMap['options'] as List<dynamic>?)?.map((option) {
        return Option(value: option as String);
      }).toList(),
    );

    final _value = fieldMap['value'];

    if (_value != null) {
      if (_value is String?) {
        _field.value = _value;
      } else if (_value is ParseFile?) {
        _field.file = _value;
      } else {
        _field.value = fieldMap['value'];
      }
    }

    return _field;
  }

  Map<String, dynamic> toMap() {
    final fieldMap = <String, dynamic>{
      'id': id,
      'label': label,
      'type': type,
      'required': required,
      'hide': hide ?? false,
    };
    if (options != null)
      fieldMap['options'] = options!.map((option) => option.value).toList();

    if (inputType != null) fieldMap['inputType'] = inputType;

    if (value != null) {
      fieldMap['value'] = (value?.isEmpty ?? true) ? null : value;
    } else if (file != null) {
      fieldMap['value'] = file;
    } else {
      fieldMap['value'] = null;
    }

    return fieldMap;
  }
}

class Option {
  String value;

  Option({required this.value}) {
    // replace [,] character if there in value
    // so that it doesn't effect decoding of multi option values encoded as comma separated string
    value = value.replaceAll(',', ' ');
  }
}
