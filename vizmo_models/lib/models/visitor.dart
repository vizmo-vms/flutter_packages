import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/parse_schemas/models.dart';
import 'package:vizmo_models/models/visitor_type.dart';

class Visitor {
  String? id;
  String? _name;
  String? email;
  String? phone;
  String? company;
  IdCardType? idType;
  bool? agreementSigned = false;
  bool? verified = false;
  String? firstName;
  String? lastName;

  ParseFile? photo;
  ParseFile? idCard;
  ParseAgreement? agreement;

  String? get name {
    if (_name != null) return _name;

    return '$firstName $lastName';
  }

  set name(String? name) {
    if (name?.isEmpty ?? true) return;
    _name = name;
  }

  Visitor({
    this.id,
    // this.name,
    this.email,
    this.phone,
    this.company,
    this.agreement,
    this.agreementSigned = false,
    this.verified = false,
    this.firstName,
    this.lastName,
    this.photo,
    this.idCard,
    this.idType,
  });
}
