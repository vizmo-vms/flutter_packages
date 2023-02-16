import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_pass/app/data/models/visitor.dart';

import 'company_schema.dart';
import 'location_schema.dart';
import 'models.dart';

class VisitorSchema extends ParseObject {
  VisitorSchema() : super(_className);

  VisitorSchema fromJson(Map<String, dynamic> objectData) {
    return super.fromJson(objectData);
  }

  static VisitorSchema fromObject(ParseObject object) {
    return VisitorSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "Visitor";

  static const String nameKey = "name";
  static const String firstNameKey = "firstName";
  static const String lastNameKey = "lastName";
  static const String phoneKey = "phone";
  static const String emailKey = "email";
  static const String phoneVerifiedKey = "phoneVerified";
  static const String companyNameKey = "companyName";
  static const String agreementKey = "agreement";
  static const String photoKey = "photo";
  static const String idCardKey = "idCard";
  static const String companyKey = "company";
  static const String locationKey = "location";

  String? get name => get<String>(nameKey);
  String? get firstName => get<String>(firstNameKey);
  String? get lastName => get<String>(lastNameKey);
  String? get phone => get<String>(phoneKey);
  String? get email => get<String>(emailKey);
  bool? get phoneVerified => get<bool>(phoneVerifiedKey);
  String? get companyName => get<String>(companyNameKey);
  ParseAgreement? get agreement =>
      ParseAgreement.fromMap(get<Map<String, dynamic>>(agreementKey) ?? {});
  ParseFile? get photo => get<ParseFile>(photoKey);
  ParseFile? get idCard => get<ParseFile>(idCardKey);
  CompanySchema? get company {
    var result = get(companyKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return CompanySchema()..fromJson(result.toJson(full: true));
    }
    return CompanySchema()..fromJson(result);
  }

  LocationSchema? get location {
    var result = get(locationKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return LocationSchema()..fromJson(result.toJson(full: true));
    }
    return LocationSchema()..fromJson(result);
  }

  Visitor toVisitor() {
    return Visitor(
      id: this.objectId,
      firstName: this.firstName,
      lastName: this.lastName,
      company: this.companyName,
      email: this.email,
      phone: this.phone,
      photoUri: this.photo?.url,
      idUri: this.idCard?.url,
      agreementSigned:
          this.agreement?.signedAt != null && this.agreement?.file != null,
      agreementUri: this.agreement?.file?.url,
      verified: this.phoneVerified,
    )..name = this.name;
  }
}
