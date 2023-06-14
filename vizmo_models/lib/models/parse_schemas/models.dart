import 'package:flutter/foundation.dart' show describeEnum;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/approval.dart';
import 'package:vizmo_models/models/health_declaration.dart';
import 'package:vizmo_models/models/host.dart';
import 'package:vizmo_models/models/parse_schemas/employee_schema.dart';
import 'package:vizmo_models/models/parse_schemas/user_schema.dart';
import 'package:vizmo_models/models/parse_schemas/visitor_type_schema.dart';
import 'package:vizmo_models/models/visitor_type.dart';
import 'package:vizmo_models/utils/extension_utils.dart';
import 'package:vizmo_models/utils/utils.dart';

import '../accept_reject.dart';
import '../enum.dart';
import '../profile.dart';

class ParseVisitorType {
  ParseVisitorType({
    this.pointer,
    this.name,
    this.displayName,
  });

  final VisitorTypeSchema? pointer;
  final String? name;
  final String? displayName;

  Map<String, dynamic> toMap() {
    return {
      'pointer': pointer?.toPointer(),
      'name': name,
      'displayName': displayName,
    };
  }

  factory ParseVisitorType.fromMap(Map<String, dynamic> map) {
    return ParseVisitorType(
      pointer: map['pointer'] == null
          ? null
          : (map['pointer'] is ParseObject
              ? VisitorTypeSchema.fromObject(map['pointer'])
              : VisitorTypeSchema().fromJson(map['pointer'])),
      name: map['name'],
      displayName: map['displayName'],
    );
  }

  VisitorType toVisitorType() {
    if (pointer?.containsKey('name') ?? false) {
      return pointer!.toVisitorType();
    }

    return VisitorType(
      id: pointer?.objectId,
      name: name,
      displayName: displayName,
    );
  }
}

class ParseAcceptReject {
  ParseAcceptReject({
    this.enabled,
    this.status,
    this.message,
  });

  final bool? enabled;
  final AcceptRejectStatus? status;
  final String? message;

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'status': status != null ? describeEnum(status!) : null,
      'message': message,
    };
  }

  factory ParseAcceptReject.fromMap(Map<String, dynamic> map) {
    if (!(map['enabled'] is bool)) {
      map['enabled'] = false;
    }
    return ParseAcceptReject(
      enabled: map['enabled'] ?? map['required'] ?? false,
      status: stringToEnum<AcceptRejectStatus>(
          AcceptRejectStatus.values, map['status']),
      message: map['message'],
    );
  }

  toAcceptReject() {
    return AcceptReject.fromMap(this.toMap());
  }
}

class ParseApproval {
  ParseApproval({
    this.required,
    this.status,
    this.message,
    this.approver,
  });

  final bool? required;
  final ApprovalStatus? status;
  final String? message;
  final EmployeeSchema? approver;

  Map<String, dynamic> toMap() {
    return {
      'required': required,
      'status': status != null ? describeEnum(status!) : null,
      'message': message,
      'approver': approver?.toPointer(),
    };
  }

  factory ParseApproval.fromMap(Map<String, dynamic> map) {
    return ParseApproval(
      required: map['required'] ?? false,
      status: stringToEnum(ApprovalStatus.values, map['status']),
      message: map['message'],
      approver: map['approver'] != null
          ? (map['approver'] is ParseObject
              ? EmployeeSchema.fromObject(map['approver'])
              : EmployeeSchema().fromJson(map['approver']))
          : null,
    );
  }

  Approval toApproval() {
    return Approval(
      required: this.required ?? false,
      status: this.status,
      message: this.message,
      approver: (this.approver?.objectId?.isNotEmpty ?? false)
          ? Approver(
              uid: this.approver?.objectId,
              name: this.approver?.user?.name,
            )
          : null,
    );
  }

  factory ParseApproval.fromApproval(Approval approval) {
    return ParseApproval(
      required: approval.required,
      approver: approval.approver?.uid?.isNotEmpty ?? false
          ? (EmployeeSchema()..objectId = approval.approver?.uid)
          : null,
      status: approval.status,
      message: approval.message,
    );
  }
}

class ParseHost {
  ParseHost({this.pointer, this.name, this.email, this.phone, this.user});

  final EmployeeSchema? pointer;
  final String? name;
  final String? email;
  final String? phone;
  final UserSchema? user;

  Map<String, dynamic> toMap() {
    final _map = {
      'pointer': pointer?.toPointer(),
      'name': name,
      'email': email,
    };

    if (phone?.isNotEmpty ?? false) {
      _map.putIfAbsent(
        'phone',
        () => phone,
      );
    }
    return _map;
  }

  factory ParseHost.fromMap(Map<String, dynamic> map) {
    return ParseHost(
      pointer: map['pointer'] == null
          ? null
          : map['pointer'] is ParseObject
              ? EmployeeSchema.fromObject(map['pointer'])
              : EmployeeSchema().fromJson(map['pointer']),
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  factory ParseHost.fromHost(Host host) {
    return ParseHost(
      email: host.email,
      name: host.name,
      phone: host.phone,
      pointer: EmployeeSchema()..objectId = host.uid,
    );
  }
  factory ParseHost.fromUser(UserProfile user) {
    return ParseHost(
      email: user.email,
      name: user.name,
      phone: user.phone,
      user: UserSchema()..objectId = user.uid,
    );
  }

  Host toHost() {
    return Host(
      uid: this.pointer?.objectId,
      cid: this.pointer?.company?.objectId,
      lid: this.pointer?.location?.objectId,
      firstName: this.pointer?.firstName,
      lastName: this.pointer?.lastName,
      email: this.pointer?.user?.email ?? this.email,
      name: this.pointer?.user?.name ?? this.name,
      phone: this.pointer?.user?.phone ?? this.phone,
      department: this.pointer?.department,
      designation: this.pointer?.designation,
    );
  }
}

class ParseHealthDeclaration {
  ParseHealthDeclaration({
    this.fields,
    this.declaredAt,
    this.approval,
  });

  List<HealthDeclarationField>? fields;
  DateTime? declaredAt;
  ParseApproval? approval;

  Map<String, dynamic> toMap() {
    return {
      'fields': fields?.map((x) => x.toMap()).toList(),
      'approval': approval?.toMap(),
      'declaredAt': declaredAt
    };
  }

  factory ParseHealthDeclaration.fromMap(Map<String, dynamic> map) {
    return ParseHealthDeclaration(
      approval: map['approval'] != null
          ? ParseApproval.fromMap(map['approval'])
          : null,
      fields: map['fields'] == null
          ? null
          : List<HealthDeclarationField>.from(
              map['fields']?.map((x) => HealthDeclarationField.fromMap(x))),
      declaredAt: Utils.getDateTime(map['declaredAt']),
    );
  }

  HealthDeclaration toHealthDeclaration() {
    return HealthDeclaration(
      approval: this.approval?.toApproval(),
      fields: this.fields,
      declaredAt: this.declaredAt,
    );
  }
}

class ParseAgreement {
  ParseAgreement({
    this.signedAt,
    this.file,
    this.content,
  });

  final DateTime? signedAt;
  final ParseFile? file;
  final String? content;

  Map<String, dynamic> toMap() {
    return {
      'signedAt': signedAt,
      'file': file, // we don't pass file from client
      'content': content,
    }..removeEmpty();
  }

  factory ParseAgreement.fromMap(Map<String, dynamic> map) {
    return ParseAgreement(
      signedAt: Utils.getDateTime(map['signedAt']),
      file: map['file'],
      content: map['content'],
    );
  }
}

class PrintJobData {
  String name;
  String? companyName;
  DateTime checkinAt;
  String? hostName;
  String purpose;
  String? sessionToken;
  String? visitorPhotoUrl;

  PrintJobData({
    required this.name,
    this.companyName,
    required this.checkinAt,
    this.hostName,
    required this.purpose,
    this.visitorPhotoUrl,
    this.sessionToken,
  });

  factory PrintJobData.fromMap(Map<String, dynamic> map) {
    return PrintJobData(
      name: map['name'] as String,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
      checkinAt: Utils.parseDate(map['checkinAt']) ?? DateTime.now(),
      hostName: map['hostName'] != null ? map['hostName'] as String : null,
      purpose: map['purpose'] as String,
      visitorPhotoUrl: map['visitorPhotoUrl'] != null
          ? map['visitorPhotoUrl'] as String
          : null,
      sessionToken:
          map['sessionToken'] != null ? map['sessionToken'] as String : null,
    );
  }
}

class PrinterError {
  PrinterError({
    this.code,
    this.message,
  });

  final String? code;
  final String? message;

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
    };
  }

  factory PrinterError.fromMap(Map<String, dynamic> map) {
    return PrinterError(
      code: map['code'],
      message: map['message'],
    );
  }
}
