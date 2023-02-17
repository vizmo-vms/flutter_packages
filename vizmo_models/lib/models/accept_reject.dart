import 'package:flutter/foundation.dart' show describeEnum;
import 'package:vizmo_models/models/approval.dart';

class AcceptReject extends Approval {
  AcceptReject() : super();

  factory AcceptReject.fromMap(Map<String, dynamic> map) {
    final _ = Approval.fromMap(map);
    return AcceptReject()
      ..required = _.required
      ..status = _.status
      ..approver = _.approver;
  }

  bool get enabled => this.required ?? false;
  bool get needApproval => enabled && status == null;

  Map<String, dynamic> toMap() {
    return {
      'enabled': this.required,
      'status': status != null ? describeEnum(status!) : null,
      'approver': approver?.toMap(),
    };
  }
}
