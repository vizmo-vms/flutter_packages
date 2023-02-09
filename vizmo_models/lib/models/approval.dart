import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/utils/extension_utils.dart';

enum ApprovalStatus {
  approved,
  rejected,
  denied,
  no_response,
}

class Approval {
  bool? required;
  ApprovalStatus? status;
  // is approver uid.
  Approver? approver;
  String? message;
  Approval({
    this.required,
    this.approver,
    this.status,
    this.message,
  });

  factory Approval.fromMap(Map<String, dynamic>? map) {
    if (map?.isEmpty ?? true) map = {};

    Approver? _approver;

    if (map!['approver'] is String) {
      _approver = Approver.fromMap({'uid': map['approver']}, isString: true);
    } else if (map['approver'] is Map) {
      _approver = Approver.fromMap(map['approver'] ?? {});
    } else if (map['approver'] is ParseObject) {
      _approver = Approver(uid: map['approver'].objectId);
    }

    return Approval(
      required: map['required'] ?? map['enabled'],
      status: stringToEnum(ApprovalStatus.values, map['status']),
      approver: _approver,
      message: map['message'] ?? map['comment'],
    );
  }

  bool get isNotApproved =>
      (this.required ?? false) && this.status != ApprovalStatus.approved;
}

class Approver {
  String? name;
  String? uid;

  Approver({
    this.name,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
    };
  }

  factory Approver.fromMap(Map<String, dynamic> map, {bool isString: false}) {
    return Approver(
      name: map['name'],
      uid: map['uid'],
    );
  }

  factory Approver.parse(dynamic approver) {
    Approver? _approver;
    if (approver is String) {
      _approver = Approver.fromMap({'uid': approver}, isString: true);
    } else if (approver is Map) {
      _approver = Approver.fromMap(Map.from(approver));
    } else if (approver is ParseObject) {
      _approver = Approver(uid: approver.objectId);
    }

    return _approver ?? Approver();
  }
}
