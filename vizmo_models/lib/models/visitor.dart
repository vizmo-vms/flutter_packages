import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/parse_schemas/models.dart';
import 'package:vizmo_models/models/visitor_type.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io' show File;

class Visitor {
  String? id;
  String? _name;
  String? email;
  String? phone;
  String? company;
  IdCardType? idType;
  String? photoUri;
  String? idUri;
  // String? idType;
  String? agreementUri;
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
    this.photoUri,
    this.idUri,
    this.agreementUri,
    this.agreementSigned = false,
    this.verified = false,
    this.firstName,
    this.lastName,
    this.photo,
    this.idCard,
    this.idType,
  });

  Visitor.fromMap(Map<String, dynamic> map)
      : email = map['email'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        phone = map['phone'],
        company = map['company'],
        photoUri = map['photoUri'],
        idUri = map['idUri'],
        idType = map['idType'],
        agreementUri = map['agreementUri'],
        agreementSigned = map['agreementSigned'] ?? false,
        verified = map['verified'] ?? false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'photoUri': photoUri,
      'idUri': idUri,
      'idType': idType,
      'agreementUri': agreementUri,
      'agreementSigned': agreementSigned,
      'verified': verified,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  bool operator ==(covariant Visitor other) {
    return (id?.isNotEmpty ?? false) && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ phone.hashCode;
  }
}
