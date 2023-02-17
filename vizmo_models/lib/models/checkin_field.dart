class CheckinField {
  String id;
  String label;
  String type;
  bool required;
  bool? hide = false;
  String? inputType;
  List<Option>? options;
  String? value;

  CheckinField(
      {required this.id,
      required this.label,
      required this.type,
      required this.required,
      this.hide,
      this.inputType,
      this.options,
      this.value});

  CheckinField.fromMap({String? id, Map<String, dynamic> fieldMap: const {}})
      : id = id ?? fieldMap['id'],
        label = fieldMap['label'],
        type = fieldMap['type'],
        required = fieldMap['required'],
        hide = fieldMap['hide'] ?? false,
        inputType = fieldMap['inputType'],
        options = (fieldMap['options'] as List<dynamic>?)?.map((option) {
          return Option(value: option as String);
        }).toList(),
        value = fieldMap['value'];

  Map<String, dynamic> toMap() {
    final fieldMap = <String, dynamic>{
      'id': id,
      'label': label,
      'type': type,
      'required': required,
      'hide': hide ?? false,
      'inputType': inputType,
      'value': value
    };
    if (options != null)
      fieldMap['options'] = options!
          .map((option) => <String, String>{'value': option.value})
          .toList();

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
