import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/parse_schemas/user_schema.dart';

import '../kiosk.dart';
import 'company_schema.dart';
import 'location_schema.dart';

class KioskSchema extends ParseObject {
  KioskSchema() : super(_className);

  static KioskSchema fromObject(ParseObject object) {
    return KioskSchema().fromJson(object.toJson(full: true));
  }

  Map<String, dynamic> toMap() => this.toJson(full: true);

  static const String _className = "Kiosk";

  static const String companyKey = "company";
  static const String locationKey = "location";
  static const String userKey = "user";
  static const String pairedKey = "paired";
  static const String passcodeKey = "passcode";
  static const String udidKey = "udid";
  static const String totpSecretKey = "totpSecret";
  static const String nameKey = "name";
  static const String deviceOSKey = "deviceOS";
  static const String appVersionKey = "appVersion";
  static const String appBuildKey = "appBuild";
  static const String onlineKey = "online";
  static const String systemVersionKey = "systemVersion";
  static const String typeKey = "type";

  CompanySchema? get company {
    var result = get(companyKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return CompanySchema()..fromJson(result.toJson(full: true));
    }
    return CompanySchema()..fromJson(result);
  }

  set company(CompanySchema? company) => set(companyKey, company?.toPointer());

  LocationSchema? get location {
    var result = get(locationKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return LocationSchema()..fromJson(result.toJson(full: true));
    }
    return LocationSchema()..fromJson(result);
  }

  set location(LocationSchema? location) =>
      set(locationKey, location?.toPointer());

  UserSchema? get user {
    var result = get(userKey);
    if (result == null) return null;

    if (result is ParseUser) {
      return UserSchema(null, null, null)..fromJson(result.toJson(full: true));
    }
    return UserSchema(null, null, null)..fromJson(result);
  }

  bool? get paired => get<bool>(pairedKey);
  set paired(bool? value) => set<bool>(pairedKey, value ?? false);
  String? get passcode => get<String>(passcodeKey);
  set passcode(String? value) => set<String?>(passcodeKey, value);
  String? get udid => get<String>(udidKey);
  String? get totpSecret => get<String>(totpSecretKey);
  String? get name => get<String>(nameKey);
  set name(String? value) => set<String?>(nameKey, value);
  bool? get online => get<bool>(onlineKey);
  set online(bool? value) => set<bool>(onlineKey, value ?? false);
  String? get deviceOS => get<String>(deviceOSKey);
  set deviceOS(String? value) => set<String?>(deviceOSKey, value);
  String? get appVersion => get<String>(appVersionKey);
  set appVersion(String? value) => set<String?>(appVersionKey, value);
  int? get appBuild => get<int>(appBuildKey);
  set appBuild(int? value) => set<int?>(appBuildKey, value);
  String? get systemVersion => get<String>(systemVersionKey);
  set systemVersion(String? value) => set<String?>(systemVersionKey, value);
  // String get kioskType => get<String>(typeKey);
  // set kioskType(String value) => set<String>(typeKey, value);

  Kiosk toKiosk() {
    return Kiosk(
      kid: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      paired: this.paired,
      passcode: this.passcode,
      totpSecret: this.totpSecret,
      udid: this.udid,
      name: this.name,
      online: this.online,
    );
  }

  void fromKiosk(Kiosk kiosk) {
    this.objectId = kiosk.kid;
    this.company = CompanySchema()..objectId = kiosk.cid;
    this.location = LocationSchema()..objectId = kiosk.lid;
    this.paired = kiosk.paired;
    this.passcode = kiosk.passcode;
    this.name = kiosk.name;
  }
}
