import 'package:flutter/foundation.dart' show describeEnum;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_pass/app/data/models/parse_schemas/visitor_schema.dart';
import 'package:vizmo_pass/app/utils/extension_utils.dart';
import 'package:vizmo_pass/app/utils/utils.dart';
import '../checkin_data.dart';
import '../checkin_field.dart';
import '../enum.dart';
import '../visitor.dart';
import 'attendee_schema.dart';
import 'company_schema.dart';
import 'employee_schema.dart';
import 'invite_schema.dart';
import 'kiosk_schema.dart';
import 'location_schema.dart';
import 'models.dart';
import 'visitor_type_schema.dart';

class VisitorLogSchema extends ParseObject {
  VisitorLogSchema({ParseHTTPClient? client})
      : super(_className, client: client);

  static VisitorLogSchema fromObject(ParseObject object) {
    return VisitorLogSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "VisitorLog";

  static const String companyKey = "company";
  static const String locationKey = "location";
  static const String visitorKey = "visitor";
  static const String visitorPointerKey = "visitor.pointer";
  static const String visitorPhoneKey = "visitor.phone";
  static const String visitorEmailKey = "visitor.email";
  static const String visitorTypeKey = "visitorType";
  static const String hostKey = "host";
  static const String fieldsKey = "fields";
  static const String photoKey = "photo";
  static const String idCardKey = "idCard";
  static const String checkinAtKey = "checkinAt";
  static const String checkoutAtKey = "checkoutAt";
  static const String inviteKey = "invite";
  static const String attendeeKey = "attendee";
  static const String sourceKey = "source";
  static const String kioskKey = "kiosk";
  static const String healthDeclarationKey = "healthDeclaration";
  static const String overstayKey = "overstay";
  static const String acceptRejectKey = "acceptReject";
  static const String approvalKey = "approval";

  static const String hostEmailKey = "host.email";
  static const String acceptRejectEnabledKey = "acceptReject.enabled";
  static const String acceptRejectStatusKey = "acceptReject.status";
  static const String approvalStatusKey = "approval.status";

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

  InviteSchema? get invite {
    var result = get(inviteKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return InviteSchema()..fromJson(result.toJson(full: true));
    }
    return InviteSchema()..fromJson(result);
  }

  AttendeeSchema? get attendee {
    var result = get(attendeeKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return AttendeeSchema()..fromJson(result.toJson(full: true));
    }
    return AttendeeSchema()..fromJson(result);
  }

  set attendee(AttendeeSchema? value) {
    if (value != null) {
      set(attendeeKey, value.toPointer());
    }
  }

  set invite(InviteSchema? value) {
    if (value != null) {
      set(inviteKey, value.toPointer());
    }
  }

  set kiosk(KioskSchema? kiosk) => set(kioskKey, kiosk?.toPointer());

  set company(CompanySchema? company) => set(companyKey, company?.toPointer());

  set location(LocationSchema? value) => set(locationKey, value?.toPointer());

  _Visitor? get visitor =>
      _Visitor.fromMap(get<Map<String, dynamic>>(visitorKey) ?? {});
  set visitor(_Visitor? visitor) =>
      set<Map<String, dynamic>>(visitorKey, visitor!.toMap());
  ParseVisitorType? get visitorType =>
      ParseVisitorType.fromMap(get<Map<String, dynamic>>(visitorTypeKey) ?? {});
  set visitorType(ParseVisitorType? type) =>
      set<Map<String, dynamic>>(visitorTypeKey, type!.toMap());
  ParseHost? get host =>
      ParseHost.fromMap(get<Map<String, dynamic>>(hostKey) ?? {});
  set host(ParseHost? host) =>
      set<Map<String, dynamic>?>(hostKey, host?.toMap());
  List<CheckinField>? get fields => List.from(get<List>(fieldsKey) ?? [])
      .map((val) => CheckinField.fromMap(fieldMap: Map.from(val)))
      .toList();
  set fields(List<CheckinField>? fields) => set<List>(
      fieldsKey, fields?.map((field) => field.toMap()).toList() ?? []);
  ParseFile? get photo => get<ParseFile>(photoKey);
  set photo(ParseFile? value) => set<ParseFile?>(photoKey, value);
  ParseFile? get idCard => get<ParseFile>(idCardKey);
  set idCard(ParseFile? value) => set<ParseFile?>(idCardKey, value);
  DateTime? get checkinAt => Utils.getDateTime(get(checkinAtKey));
  set checkinAt(DateTime? value) => set(checkinAtKey, value);
  DateTime? get checkoutAt => Utils.getDateTime(get(checkoutAtKey));
  set checkoutAt(DateTime? value) => set(checkoutAtKey, value);

  SourceEnum? get source =>
      stringToEnum<SourceEnum>(SourceEnum.values, get<String>(sourceKey));
  set source(SourceEnum? value) =>
      set<String>(sourceKey, describeEnum(SourceEnum.kiosk));
  ParseHealthDeclaration? get healthDeclaration =>
      ParseHealthDeclaration.fromMap(
          get<Map<String, dynamic>>(healthDeclarationKey) ?? {});
  set healthDeclaration(ParseHealthDeclaration? healthDeclaration) =>
      set<Map<String, dynamic>?>(
          healthDeclarationKey, healthDeclaration?.toMap());
  _Overstay? get overstay =>
      _Overstay.fromMap(get<Map<String, dynamic>>(overstayKey) ?? {});
  ParseAcceptReject? get acceptReject => ParseAcceptReject.fromMap(
      get<Map<String, dynamic>>(acceptRejectKey) ?? {});
  ParseApproval? get approval =>
      ParseApproval.fromMap(get<Map<String, dynamic>>(approvalKey) ?? {});

  Future<void> fromCheckinData(CheckinData data, String cid, String lid) async {
    this.company = CompanySchema()..objectId = cid;
    this.location = LocationSchema()..objectId = lid;
    this.visitorType = ParseVisitorType(
      pointer: VisitorTypeSchema()..objectId = data.visitorType?.id,
      name: data.visitorType?.name,
      displayName: data.visitorType?.displayName,
    );
    this.checkinAt = DateTime.now();
    final _visitor = _Visitor(
      companyName: data.visitor?.company,
      email: data.visitor?.email,
      name: data.visitor?.name,
      phone: data.visitor?.phone,
      firstName: data.visitor?.firstName,
      lastName: data.visitor?.lastName,
    );
    if (data.visitor?.id?.isNotEmpty ?? false) {
      _visitor.pointer = VisitorSchema()..objectId = data.visitor?.id;
    }
    // TODO: file handling
    if (data.visitorAgreementData?.isNotEmpty ?? false) {
      try {
        _visitor.agreement = ParseAgreement(
          signedAt: DateTime.now(),
          content: data.visitorAgreementData,
        );
      } catch (e) {
        print("Error: $e");
      }
    }
    this.visitor = _visitor;
    if (data.host?.uid?.isNotEmpty ?? false) {
      this.host = ParseHost(
        pointer: EmployeeSchema()..objectId = data.host?.uid,
        name: data.host?.name,
        email: data.host?.email,
      );
    }

    this.fields = data.fields.values.toList();

    if (data.visitorPhotoFile != null) {
      this.photo = ParseFile(data.visitorPhotoFile);
    }

    if (data.visitorIdFile != null) {
      this.idCard = ParseFile(data.visitorIdFile);
    }

    if (data.healthDeclaration?.fields?.isNotEmpty ?? false) {
      this.healthDeclaration = ParseHealthDeclaration(
        fields: data.healthDeclaration?.fields,
        declaredAt: DateTime.now(),
      );
    }

    // this.kiosk = KioskSchema()..objectId = kioskId;
    if ((data.iid?.isNotEmpty ?? false) &&
        (data.attendeeId?.isNotEmpty ?? false)) {
      this.invite = InviteSchema()..objectId = data.iid;
      this.attendee = AttendeeSchema()..objectId = data.attendeeId;
    }
  }

  CheckinData toCheckinData() {
    return CheckinData(
      id: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      iid: this.invite?.objectId,
      attendeeId: this.attendee?.objectId,
      attendee: this.attendee?.toAttendee(),
      visitor: visitor?.toVisitor(),
      visitorType: visitorType?.toVisitorType(),
      host: host?.toHost(),
      checkinDate: checkinAt,
      checkoutDate: checkoutAt,
      visitorTypeKey: visitorType?.pointer?.objectId,
      healthDeclaration: healthDeclaration?.toHealthDeclaration(),
      acceptReject: acceptReject?.toAcceptReject(),
      approval: approval?.toApproval(),
    )..visitor?.photoUri = this.photo?.url;
  }
}

class _Overstay {
  _Overstay({
    this.overstayed,
    this.notificationsSent,
  });

  final bool? overstayed;
  final bool? notificationsSent;

  Map<String, dynamic> toMap() {
    return {
      'overstayed': overstayed,
      'notificationsSent': notificationsSent,
    };
  }

  factory _Overstay.fromMap(Map<String, dynamic> map) {
    return _Overstay(
      overstayed: map['overstayed'],
      notificationsSent: map['notificationsSent'],
    );
  }
}

class _Visitor {
  _Visitor({
    this.pointer,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.companyName,
    // this.agreement,
  });

//TODO: implement visitor Schema
  VisitorSchema? pointer;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? companyName;
  ParseAgreement? agreement;

  Map<String, dynamic> toMap() {
    final _map = {
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'agreement': agreement?.toMap(),
    };

    if (pointer?.objectId != null) {
      _map.putIfAbsent('pointer', () => pointer?.toPointer());
    }
    if (email?.isNotEmpty ?? false) {
      _map.putIfAbsent('email', () => email);
    }
    if (companyName?.isNotEmpty ?? false) {
      _map.putIfAbsent('companyName', () => companyName);
    }

    return _map..removeEmpty();
  }

  factory _Visitor.fromMap(Map<String, dynamic> map) {
    return _Visitor(
      pointer: map['pointer'] is ParseObject
          ? VisitorSchema.fromObject(map['pointer'] ?? {})
          : VisitorSchema().fromJson(map['pointer'] ?? {}),
      name: map['name'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phone: map['phone'],
      companyName: map['companyName'],
    )..agreement = ParseAgreement.fromMap(map['agreement'] ?? {});
  }

  Visitor toVisitor() {
    // has attributes
    if (this.pointer?.containsKey('phone') ?? false) {
      return this.pointer!.toVisitor();
    }
    return Visitor(
      id: this.pointer?.objectId,
      firstName: this.firstName,
      lastName: this.lastName,
      company: this.companyName,
      email: this.email,
      phone: this.phone,
      agreementSigned:
          this.agreement?.signedAt != null && this.agreement?.file != null,
      agreementUri: this.agreement?.file?.url,
    )..name = this.name;
  }
}
