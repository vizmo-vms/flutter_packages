import 'dart:io' show File;
import 'dart:typed_data' show Uint8List;

import 'package:vizmo_pass/app/data/models/approval.dart' show Approval;
import 'package:vizmo_pass/app/data/models/visitor.dart' show Visitor;
import 'package:vizmo_pass/app/data/models/visitor_type.dart' show VisitorType;

import 'accept_reject.dart' show AcceptReject;
import 'attendee.dart' show Attendee;
import 'checkin_field.dart' show CheckinField;
import 'health_declaration.dart' show HealthDeclaration;
import 'host.dart' show Host;

class CheckinData {
  String? id;
  Visitor? visitor;
  Map<String, CheckinField> fields = <String, CheckinField>{};
  Host? host;
  VisitorType? visitorType;
  String? visitorTypeKey;
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

  ///Invite ID -  useful to know if this visitor is invited
  String? iid;
  String? attendeeId;
  bool? internal;
  Attendee? attendee;

  AcceptReject? acceptReject;
  Approval? approval;

  //user defined not from database
  String? cid;
  String? lid;
  String? title;

  File? visitorPhotoFile;
  File? visitorIdFile;

  CheckinData({
    this.id,
    this.visitor,
    this.host,
    this.visitorType,
    this.visitorTypeKey,
    this.visitorPhotoFile,
    this.visitorAgreementData,
    this.healthDeclaration,
    this.checkinDate,
    this.checkoutDate,
    this.returningVisitor = false,
    this.lid,
    this.cid,
    this.iid,
    this.attendeeId,
    this.attendee,
    this.acceptReject,
    this.approval,
  }) : fields = <String, CheckinField>{};
}
