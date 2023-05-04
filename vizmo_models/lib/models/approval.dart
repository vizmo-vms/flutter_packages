import 'package:flutter/foundation.dart' show describeEnum;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/utils/extension_utils.dart';

enum ApprovalStatus {
  accepted,
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
  List<Approver> approvers;
  Approval({
    this.required,
    this.approver,
    this.status,
    this.message,
    this.approvers: const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'required': required ?? false,
      'status': status != null ? describeEnum(status!) : null,
      'approver': approver?.toMap(),
    };
  }

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
      approvers: List.from(map['approvers'] ?? []).map((e) {
        if (e is String) {
          return Approver.fromMap({'uid': e}, isString: true);
        } else {
          return Approver.fromMap(Map.from(e ?? {}));
        }
      }).toList(),
    );
  }

  bool get isNotApproved =>
      (this.required ?? false) && this.status != ApprovalStatus.approved;

  bool get isDenied =>
      this.status == ApprovalStatus.no_response ||
      this.status == ApprovalStatus.denied ||
      this.status == ApprovalStatus.rejected;
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
