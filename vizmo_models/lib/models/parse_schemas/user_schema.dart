import 'dart:io' show File;

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/parse_schemas/kiosk_schema.dart';
import 'package:vizmo_models/models/parse_schemas/location_schema.dart';
import 'package:vizmo_models/models/profile.dart';

import 'company_schema.dart';

class UserSchema extends ParseUser implements ParseCloneable {
  UserSchema({
    String? username,
    String? password,
    String? emailAddress,
  }) : super(username, password, emailAddress);

  // static const String _className = "_User";

  UserSchema.forQuery() : super.forQuery();

  String? get uid => this.objectId;

  static UserSchema fromObject(ParseObject object) {
    return UserSchema().fromJson(object.toJson(full: true));
  }

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
  static const String locationsKey = "locations";
  static const String kioskKey = "kiosk";
  static const String notificationsKey = "notifications";
  static const String fcmTokenKey = "fcmToken";
  static const String typeKey = "type";
  static const String photoKey = "photo";

  String? get username => get<String>(usernameKey);
  String? get name => get<String>(nameKey);
  String? get email => get<String>(emailKey);
  String? get phone => get<String>(phoneKey);
  set phone(String? phone) => set(phoneKey, phone);
  String? get firstName => get<String>(firstNameKey);
  set firstName(String? firstName) => set(firstNameKey, firstName);
  String? get lastName => get<String>(lastNameKey);
  set lastName(String? lastName) => set(lastNameKey, lastName);
  bool? get disabled => get<bool>(disabledKey, defaultValue: false);
  bool? get emailVerified => get<bool>(emailVerifiedKey, defaultValue: false);
  Notifications? get notifications {
    final _val = get(notificationsKey);
    if (_val == null) return null;

    return Notifications.fromMap(Map.from(_val));
  }

  set notifications(Notifications? notification) {
    if (notification == null) return;

    set(notificationsKey, notification.toMap());
  }

  String? get fcmToken => get<String>(fcmTokenKey);
  set fcmToken(String? fcmToken) => set(fcmTokenKey, fcmToken);
  ParseFile? get photo => get<ParseFile>(photoKey);
  set photo(ParseFile? file) => set(photoKey, file);

  CompanySchema get company {
    var result = get(companyKey);
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

  List<LocationSchema> get locations {
    var result = get(locationsKey);
    if (result is ParseObject) {
      return [LocationSchema()..fromJson(result.toJson(full: true))];
    } else if (result is List && (result.isNotEmpty)) {
      return result
          .map((e) => LocationSchema()..fromJson(e.toJson(full: true)))
          .toList();
    }
    return [LocationSchema()..fromJson(result)];
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

  UserProfile toUserProfile() {
    return UserProfile(
      uid: this.objectId,
      cid: this.company.objectId,
      name: this.name,
      firstName: this.firstName,
      lastName: this.lastName,
      email: this.email,
      phone: this.phone,
      photo: this.photo?.url,
      locations: this.locations.map((e) => e.toLocation()).toList(),
    );
  }

  fromUserProfile(UserProfile user, {File? photo}) {
    if (user.firstName != null) this.firstName = user.firstName;
    if (user.lastName != null) this.lastName = user.lastName;
    if (user.phone != null) this.phone = user.phone;
    if (photo != null) this.photo = ParseFile(photo);
    if (user.notifications != null) this.notifications = user.notifications;
    if (user.fcmToken != null) this.fcmToken = user.fcmToken;
  }
}
