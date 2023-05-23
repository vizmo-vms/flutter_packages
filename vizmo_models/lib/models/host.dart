import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/parse_schemas/employee_schema.dart';

class Host {
  String? cid;
  String? lid;
  String? uid;
  String? _name;
  String? email;
  String? phone;
  String? department;
  String? designation;
  String? firstName;
  String? lastName;
  String? userId;
  bool? hide;

  Host(
      {this.uid,
      String? name,
      this.email,
      this.cid,
      this.lid,
      this.phone,
      this.department,
      this.designation,
      this.firstName,
      this.lastName,
      this.userId,
      this.hide})
      : _name = name;

  String? get name {
    if (_name?.isNotEmpty ?? false) return _name;

    return '$firstName $lastName';
  }

  set name(String? name) {
    if (name?.isEmpty ?? true) return;
    _name = name;
  }

  Host.fromMap(String? hostId, Map<String, dynamic> hostMap)
      : uid = hostId ?? hostMap['uid'] ?? hostMap['id'],
        cid = hostMap['cid'],
        // name = hostMap['name'],
        email = hostMap['email'],
        phone = hostMap['phone'],
        department = hostMap['department'],
        designation = hostMap['designation'];

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone?.isEmpty ?? true ? null : phone,
      'department': department,
      'designation': designation,
    };
  }

  factory Host.parse(dynamic host) {
    if (host == null) return Host();

    if (host is String) {
      return Host(uid: host);
    } else if (host is Map) {
      return Host.fromMap(null, Map.from(host));
    } else if (host is ParseObject) {
      return EmployeeSchema.fromObject(host).toHost();
    }

    return Host();
  }
  void copyWithHost(Host? host) {
    email = host?.email ?? email;
    phone = host?.phone ?? phone;
    department = host?.department ?? department;
    designation = host?.designation ?? designation;
    firstName = host?.firstName ?? firstName;
    lastName = host?.lastName ?? lastName;
    hide = host?.hide ?? hide;
  }
}
