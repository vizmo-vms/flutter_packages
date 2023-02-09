import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/parse_schemas/kiosk_schema.dart';
import 'package:vizmo_models/models/parse_schemas/location_schema.dart';

import 'company_schema.dart';

class UserSchema extends ParseUser implements ParseCloneable {
  UserSchema(
    String? username,
    String? password,
    String? emailAddress,
  ) : super(username, password, emailAddress);

  // static const String _className = "_User";

  String? get uid => this.objectId;

  static const String usernameKey = "username";
  static const String passwordKey = "password";
  static const String nameKey = "name";
  static const String firstNameKey = "firstName";
  static const String lastNameKey = "lastName";
  static const String emailKey = "email";
  static const String phoneKey = "phone";
  static const String emailVerifiedKey = "emailVerified";
  static const String disabledKey = "disabled";
  static const String companyKey = "company";
  static const String locationKey = "locations";
  static const String kioskKey = "kiosk";
  static const String notificationsKey = "notifications";
  static const String fcmTokenKey = "fcmToken";
  static const String typeKey = "type";

  String? get username => get<String>(usernameKey);
  String? get password => get<String>(passwordKey);
  String? get name => get<String>(nameKey);
  String? get email => get<String>(emailKey);
  String? get phone => get<String>(phoneKey);
  String? get firstName => get<String>(firstNameKey);
  String? get lastName => get<String>(lastNameKey);
  bool? get disabled => get<bool>(disabledKey, defaultValue: false);
  bool? get emailVerified => get<bool>(emailVerifiedKey, defaultValue: false);
  Object? get notifications => get<Object>(notificationsKey);
  String? get fcmToken => get<String>(fcmTokenKey);
  // String get type => get<String>(typeKey);

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
    } else if (result is List && result.isNotEmpty) {
      return LocationSchema()..fromJson(result.first.toJson(full: true));
    }
    return LocationSchema()..fromJson(result);
  }

  KioskSchema? get kiosk {
    var result = get(kioskKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return KioskSchema()..fromJson(result.toJson(full: true));
    }
    return KioskSchema()..fromJson(result);
  }

  set kiosk(KioskSchema? kiosk) => set(kioskKey, kiosk?.toPointer());

  // company: { type: 'Pointer', targetClass: 'Company' },
  // locations: { type: 'Array' },
  // kiosk: { type: 'Pointer', targetClass: 'Kiosk' },
  // visitor: { type: 'Pointer', targetClass: 'Visitor' },
  // notifications: { type: 'Object' },
  // fcmToken: { type: 'String' },
  // webFcmToken: { type: 'String' },
  // type: { type: 'String', required: true }

}
