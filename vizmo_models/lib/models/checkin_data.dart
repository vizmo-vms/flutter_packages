import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/accept_reject.dart';
import 'package:vizmo_models/models/attendee.dart';
import 'package:vizmo_models/models/parse_schemas/models.dart';
import 'package:vizmo_models/models/visitor.dart';
import 'package:vizmo_models/models/visitor_type.dart';

import 'approval.dart';
import 'checkin_field.dart';
import 'health_declaration.dart';
import 'host.dart';

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
  String? inviteeId;
  bool? internal;
  Attendee? invitee;

  ParseFile? visitorPhotoFile;
  ParseFile? visitorIdFile;
  String? sessionUrl;

  CheckinData({
    this.id,
    this.cid,
    this.lid,
    this.visitor,
    this.host,
    this.visitorType,
    this.visitorTypeKey,
    this.visitorAgreement,
    this.healthDeclaration,
    this.checkinDate,
    this.checkoutDate,
    this.returningVisitor = false,
    this.visitorIdCardType,
    this.fields: const {},
    this.acceptReject,
    this.approval,
  });
}
