import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/parse_schemas/user_schema.dart';

import '../host.dart';
import 'company_schema.dart';
import 'location_schema.dart';

class EmployeeSchema extends ParseObject {
  EmployeeSchema() : super(_className);

  static const String _className = 'Employee';

  // company: { type: 'Pointer', targetClass: 'Company', required: true },
  //   location: { type: 'Pointer', targetClass: 'Location', required: true },
  //   hide: { type: 'Boolean' },
  //   department: { type: 'String' },
  //   designation: { type: 'String' },
  //   assistant: { type: 'Pointer', targetClass: 'Employee' },
  //   user: { type: 'Pointer', targetClass: '_User' },
  //   slackId: { type: 'String' }

  static const String companyKey = 'company';
  static const String locationKey = 'location';
  static const String hideKey = 'hide';
  static const String departmentKey = 'department';
  static const String designationKey = 'designation';
  static const String assistantKey = 'assistant';
  static const String userKey = 'user';
  static const String slackIdKey = 'slackId';
  static const String nameKey = 'name';
  static const String firstNameKey = 'firstName';
  static const String lastNameKey = 'lastName';
  static const String emailKey = 'email';
  static const String phoneKey = 'phone';

  static EmployeeSchema fromObject(ParseObject object) {
    return EmployeeSchema().fromJson(object.toJson(full: true))
        as EmployeeSchema;
  }

  CompanySchema? get company {
    var result = get(companyKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return CompanySchema().fromJson(result.toJson(full: true));
    }
    return CompanySchema().fromJson(result);
  }

  LocationSchema? get location {
    var result = get(locationKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return LocationSchema()..fromJson(result.toJson(full: true));
    }
    return LocationSchema()..fromJson(result);
  }

  bool? get hide => get<bool>(hideKey);
  String? get department => get<String>(departmentKey);
  String? get designation => get<String>(designationKey);
  String? get name => get<String>(nameKey);
  String? get firstName => get<String>(firstNameKey);
  String? get lastName => get<String>(lastNameKey);
  String? get email => get<String>(emailKey);
  String? get phone => get<String>(phoneKey);
  EmployeeSchema? get assistant {
    var result = get(assistantKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return EmployeeSchema()..fromJson(result.toJson(full: true));
    }
    return EmployeeSchema()..fromJson(result);
  }

  UserSchema? get user {
    var result = get(userKey);
    if (result == null) return null;

    if (result is ParseUser) {
      return UserSchema(null, null, null)..fromJson(result.toJson(full: true));
    }
    return UserSchema(null, null, null)..fromJson(result);
  }

  String? get slackId => get<String>(slackIdKey);

  Host toHost() {
    return Host(
      uid: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      email: this.email,
      name: this.name,
      firstName: this.firstName,
      lastName: this.lastName,
      phone: this.phone,
      department: this.department,
      designation: this.designation,
    );
  }
}
