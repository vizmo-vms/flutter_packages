import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/parse_schemas/models.dart';
import 'package:vizmo_models/models/visitor_type.dart';

import 'checkin_field.dart';
import 'enum.dart';
import 'health_declaration.dart';

class Attendee {
  String? id;

  String? name;

  String? firstName;
  String? lastName;

  ///
  /// email should be present for internal
  ///
  String? email;

  ///
  /// mobile number in E.164 format(removed country code)
  ///
  String? phone;

  ///
  /// Photo download url
  ///
  ParseFile? photo;

  ///
  /// saving the response.
  ///
  RSVP? rsvp;

  HealthDeclaration? healthDeclaration;

  String? companyName;

  ParseFile? idCard;

  IdCardType? idCardType;

  ParseAgreement? agreement;

  Map<String, CheckinField>? fields;

  bool? preFilled;

  InviteType? type;

  String? cid;

  String? lid;

  String? inviteId;

  //computed
  int? numberOfOccurrences;
  bool? usedToday;

  Attendee({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.healthDeclaration,
    this.email,
    this.phone,
    this.photo,
    this.rsvp,
    this.preFilled,
    this.numberOfOccurrences: 0,
    this.companyName,
    this.idCard,
    this.idCardType,
    this.agreement,
    this.fields,
    this.type,
    this.usedToday: false,
    this.cid,
    this.lid,
    this.inviteId,
  });

  bool get internal => type == InviteType.internal;
}
