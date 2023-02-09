import 'package:flutter/foundation.dart';

import 'approval.dart';

class HealthDeclarationField {
  final String? id;
  final String? title;
  final bool? required;
  bool? value;

  HealthDeclarationField({
    this.id,
    this.title,
    this.required,
    this.value,
  });

  HealthDeclarationField.fromMap(Map<String, dynamic> fieldMap)
      : id = fieldMap['id'],
        title = fieldMap['title'],
        required = fieldMap['required'],
        value = fieldMap['value'];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'required': this.required,
      'value': this.value,
    };
  }

  bool get preFilled =>
      !(this.required ?? false) || (this.required! && (this.value != null));
}

class HealthDeclaration {
  HealthDeclarationTemperature? temperature;
  List<HealthDeclarationField>? fields;
  Approval? approval;
  DateTime? declaredAt;
  HealthDeclaration(
      {this.temperature, this.fields, this.approval, this.declaredAt});

  bool get isRejected => this.approval?.status == ApprovalStatus.rejected;

  bool get preFilled =>
      (this.fields?.isNotEmpty ?? false) &&
      (this.fields?.every((val) => !(val.required ?? false) || val.preFilled) ??
          false);

  // If hd is filled, it should be valid (within 24 hours of upcoming event, we need to make this since we have re-declaration)
  // if hd is filled and not valid, then ask them to fill hd (CHANGE IN SCHEMA: Do not send declared at when sending healthDeclaration)
  // if hd is not filled, then ask them to fill hd (CHANGE IN SCHEMA: Do not send declared at when sending healthDeclaration)
  bool get isNotValidHD {
    if (isRejected) throw 'HealthDeclaration is rejected, Invalid invite';
    return !(preFilled) ||
        // this.approval?.status == null ||
        (declaredAt == null ||
            DateTime.now().difference(declaredAt!).inMinutes > (23 * 60 + 30));
  }
}

class HealthDeclarationTemperature {
  num? value;
  TemperatureUnit? unit;

  HealthDeclarationTemperature({this.value, this.unit});

  HealthDeclarationTemperature.fromMap(Map<String, dynamic> map) {
    this.value = map['value'] as num;
    this.unit = map['unit'] == 'C' ? TemperatureUnit.C : TemperatureUnit.F;
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'unit': unit != null ? describeEnum(unit!) : null,
    };
  }
}

enum TemperatureUnit { F, C }
