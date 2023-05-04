import 'dart:io' show File;
import 'dart:typed_data' show Uint8List;

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/approval.dart' show Approval;
import 'package:vizmo_models/models/parse_schemas/models.dart';
import 'package:vizmo_models/models/visitor.dart' show Visitor;
import 'package:vizmo_models/models/visitor_type.dart'
    show IdCardType, VisitorType;

import 'accept_reject.dart' show AcceptReject;
import 'attendee.dart' show Attendee;
import 'checkin_field.dart' show CheckinField;
import 'health_declaration.dart' show HealthDeclaration;
import 'host.dart' show Host;

class CheckinData {
  String? id;
  String? cid;
  String? lid;
  Visitor? visitor;
  Map<String, CheckinField> fields = <String, CheckinField>{};
  Host? host;
  VisitorType? visitorType;
  String? visitorTypeKey;
  IdCardType? visitorIdCardType;
  ParseAgreement? visitorAgreement;
  Uint8List? visitorPhotoData;
  Uint8List? visitorIdData;
  String? visitorAgreementData;
  DateTime? checkinDate;
  DateTime? checkoutDate;
  bool? returningVisitor;
  String source = 'kiosk';
  String? kioskId;
  HealthDeclaration? healthDeclaration;
  bool? invitePreFilled = false;

  AcceptReject? acceptReject;
  Approval? approval;

  ///Invite ID -  useful to know if this visitor is invited
  String? iid;
  bool? internal;

  ParseFile? visitorPhotoFile;
  ParseFile? visitorIdFile;
  String? sessionUrl;

  ///Invite ID -  useful to know if this visitor is invited

  String? attendeeId;

  Attendee? attendee;

  //user defined not from database

  String? title;

  CheckinData(
      {this.id,
      this.visitor,
      this.host,
      this.visitorType,
      this.visitorTypeKey,
      this.visitorAgreement,
      this.visitorPhotoFile,
      this.visitorAgreementData,
      this.healthDeclaration,
      this.checkinDate,
      this.checkoutDate,
      this.returningVisitor = false,
      this.visitorIdCardType,
      this.fields: const {},
      this.acceptReject,
      this.approval,
      this.attendeeId,
      this.iid,
      this.attendee,
      this.lid,
      this.cid});
}
