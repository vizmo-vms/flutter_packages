import 'dart:convert';

import 'package:vizmo_models/models/role.dart';
import 'package:vizmo_models/models/settings.dart';

import 'location.dart';

class UserProfile {
  String? uid;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? department;
  String? designation;
  String? cid;
  Map<String, Location> locations = {};
  List<String> lids = [];
  Notifications? notifications;

  ///{lid:Role}
  ///
  ///Role: 'admin' | 'billing-admin' | 'receptionist' | 'security' | 'location-admin' | 'employee' | 'kiosk'

  ///lid: settings
  Map<String, Settings> settings = {};

  /// possible values
  ///
  /// * vizmo_admin
  /// * admin
  /// * location-admin
  /// * employee
  /// * billing-admin
  /// * receptionist
  /// * security
  List<Role> roles = [];
  String? photo;
  String? fcmToken;

  UserProfile(
      {this.uid,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.department,
      this.designation,
      this.cid,
      this.roles = const [],
      this.photo,
      List<Location> locations = const [],
      this.notifications,
      this.fcmToken})
      : locations =
            locations.asMap().map((key, value) => MapEntry(value.key!, value)),
        lids = locations.map((e) => e.key!).toList();

  void copyWith({required Map<String, dynamic> map}) {
    if (map.isEmpty) return;

    this.name = map['name'] ?? this.name;
    this.firstName = map['firstName'] ?? this.firstName;
    this.lastName = map['lastName'] ?? this.lastName;
    this.phone = map['phone'] ?? this.phone;
    this.photo = map['photo'] ?? this.photo;
    this.department = map['department'] ?? this.department;
    this.designation = map['designation'] ?? this.designation;
    this.notifications = map['notifications'] != null
        ? Notifications.fromMap(Map.from(map['notifications'] ?? {}))
        : this.notifications;
  }

  void copyFromUser({UserProfile? user}) {
    if (user == null) return;
    this.name = (user.name?.isNotEmpty ?? false) ? user.name : this.name;
    this.firstName =
        (user.firstName?.isNotEmpty ?? false) ? user.firstName : this.firstName;
    this.lastName =
        (user.lastName?.isNotEmpty ?? false) ? user.lastName : this.lastName;
    this.phone = (user.phone?.isNotEmpty ?? false) ? user.phone : this.phone;
    this.photo = (user.photo?.isNotEmpty ?? false) ? user.photo : this.photo;
    this.department = (user.department?.isNotEmpty ?? false)
        ? user.department
        : this.department;
    this.designation = (user.designation?.isNotEmpty ?? false)
        ? user.designation
        : this.designation;
    // this.settings = user.settings ?? this.settings;
    this.notifications =
        user.notifications ?? this.notifications ?? Notifications();
  }

  // Host toHost() {
  //   return Host(
  //     uid: uid,
  //     name: name,
  //     firstName: firstName,
  //     lastName: lastName,
  //     email: email,
  //     department: department,
  //     designation: designation,
  //     phone: phone,
  //   );
  // }
}

class Notifications {
  bool email;
  bool sms;
  bool push;
  Notifications({
    this.email: true,
    this.sms: true,
    this.push: true,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'sms': sms,
      'push': push,
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      email: map['email'] ?? true,
      sms: map['sms'] ?? true,
      push: map['push'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notifications.fromJson(String source) =>
      Notifications.fromMap(json.decode(source));
}
