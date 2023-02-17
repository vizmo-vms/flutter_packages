import 'package:flutter/foundation.dart' show describeEnum;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/attendee.dart';
import 'package:vizmo_models/utils/extension_utils.dart';

import '../checkin_data.dart';
import '../checkin_field.dart';
import '../enum.dart';
import '../visitor_type.dart';
import 'company_schema.dart';
import 'location_schema.dart';
import 'models.dart';

class AttendeeSchema extends ParseObject {
  AttendeeSchema({ParseHTTPClient? client}) : super(_className, client: client);

  static AttendeeSchema fromObject(ParseObject object) {
    return AttendeeSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "Attendee";

  static String companyKey = 'company';
  static String locationKey = 'location';
  // static String inviteKey = 'invite';
  // computed property, only getter is available
  static String nameKey = 'name';
  static String firstNameKey = 'firstName';
  static String lastNameKey = 'lastName';
  static String emailKey = 'email';
  static String phoneKey = 'phone';
  static String photoKey = 'photo';
  static String rsvpKey = 'rsvp';
  static String healthDeclarationKey = 'healthDeclaration';
  static String companyNameKey = 'companyName';
  static String idCardKey = 'idCard';
  static String idCardTypeKey = 'idCardType';
  static String agreementKey = 'agreement';
  static String fieldsKey = 'fields';
  static String preFilledKey = 'preFilled';
  static String typeKey = 'type';

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

  set company(CompanySchema? company) => set(companyKey, company?.toPointer());

  set location(LocationSchema? value) => set(locationKey, value?.toPointer());

  // InviteSchema? get invite {
  //   var result = get(inviteKey);
  //   if (result == null) return null;

  //   if (result is ParseObject) {
  //     return InviteSchema()..fromJson(result.toJson(full: true));
  //   }
  //   return InviteSchema()..fromJson(result);
  // }

  String? get name => get<String?>(nameKey);

  // set name(String? name) => set<String?>(nameKey, name);

  String? get firstName => get<String?>(firstNameKey);
  set firstName(String? firstName) =>
      set<String?>(firstNameKey, firstName?.trim());

  String? get lastName => get<String?>(lastNameKey);
  set lastName(String? lastName) => set<String?>(lastNameKey, lastName?.trim());

  String? get email => get<String?>(emailKey);
  set email(String? email) =>
      set<String?>(emailKey, (email?.isNotEmpty ?? false) ? email : null);

  String? get phone => get<String?>(phoneKey);
  set phone(String? phone) =>
      set<String?>(phoneKey, (phone?.isNotEmpty ?? false) ? phone : null);

  ParseFile? get photo => get<ParseFile?>(photoKey);
  set photo(ParseFile? photo) => set<ParseFile?>(photoKey, photo);

  RSVP? get rsvp => stringToEnum<RSVP>(RSVP.values, get<String?>(rsvpKey));
  set rsvp(RSVP? rsvp) =>
      set<String?>(rsvpKey, rsvp != null ? describeEnum(rsvp) : null);

  ParseHealthDeclaration? get healthDeclaration {
    if (get<Map<String, dynamic>>(healthDeclarationKey) == null) return null;
    return ParseHealthDeclaration.fromMap(
        get<Map<String, dynamic>>(healthDeclarationKey) ?? {});
  }

  set healthDeclaration(ParseHealthDeclaration? healthDeclaration) =>
      set<Map<String, dynamic>?>(
          healthDeclarationKey, healthDeclaration?.toMap());

  String? get companyName => get<String?>(companyNameKey);
  set companyName(String? companyName) => set<String?>(
      companyNameKey, (companyName?.isNotEmpty ?? false) ? companyName : null);

  ParseFile? get idCard => get<ParseFile?>(idCardKey);
  set idCard(ParseFile? idCard) => set<ParseFile?>(idCardKey, idCard);

  IdCardType? get idCardType {
    if (get<Map<String, dynamic>>(idCardTypeKey) == null) return null;
    return IdCardType.fromMap(get<Map<String, dynamic>>(idCardTypeKey) ?? {});
  }

  set idCardType(IdCardType? idCardType) =>
      set<Map<String, dynamic>?>(idCardTypeKey, idCardType?.toMap());

  ParseAgreement? get agreement {
    if (get<Map<String, dynamic>>(agreementKey) == null) return null;
    return ParseAgreement.fromMap(
        get<Map<String, dynamic>>(agreementKey) ?? {});
  }

  set agreement(ParseAgreement? agreement) =>
      set<Map<String, dynamic>?>(agreementKey, agreement?.toMap());

  List<CheckinField>? get fields => List.from(get<List>(fieldsKey) ?? [])
      .map((val) => CheckinField.fromMap(fieldMap: Map.from(val)))
      .toList();
  set fields(List<CheckinField>? fields) => set<List>(
      fieldsKey, fields?.map((field) => field.toMap()).toList() ?? []);

  bool? get preFilled => get<bool?>(preFilledKey);
  set preFilled(bool? preFilled) => set<bool?>(preFilledKey, preFilled);

  InviteType? get type =>
      stringToEnum<InviteType>(InviteType.values, get<String?>(typeKey));
  set type(InviteType? type) => set<String?>(typeKey, describeEnum(type!));

  void fromCheckinData(
      String cid, String lid, String attendeeId, CheckinData checkinData) {
    this.objectId = attendeeId;
    this.company = CompanySchema()..objectId = cid;
    this.location = LocationSchema()..objectId = lid;
    this.firstName = checkinData.visitor?.firstName;
    this.lastName = checkinData.visitor?.lastName;
    if (checkinData.visitor?.email?.isNotEmpty ?? false)
      this.email = checkinData.visitor?.email;
    if (checkinData.visitor?.phone?.isNotEmpty ?? false)
      this.phone = checkinData.visitor?.phone;

    if (checkinData.visitorPhotoFile != null) {
      this.photo = checkinData.visitorPhotoFile;
    }

    if (checkinData.visitorAgreement != null) {
      try {
        this.agreement = checkinData.visitorAgreement;
      } catch (e) {
        print("Error: $e");
      }
    }

    if (checkinData.visitorIdFile != null) {
      this.idCard = checkinData.visitorIdFile;
      this.idCardType = checkinData.visitorIdCardType;
    }

    if (checkinData.healthDeclaration != null) {
      this.healthDeclaration = ParseHealthDeclaration(
          fields: checkinData.healthDeclaration?.fields,
          approval: ParseApproval.fromApproval(
              checkinData.healthDeclaration!.approval!),
          declaredAt:
              checkinData.healthDeclaration!.declaredAt ?? DateTime.now());
    }

    this.fields = checkinData.fields.values.toList();
  }

  Attendee toAttendee() {
    return Attendee(
      cid: company?.objectId,
      lid: location?.objectId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      photo: photo,
      rsvp: rsvp,
      healthDeclaration: healthDeclaration?.toHealthDeclaration(),
      companyName: companyName,
      idCard: idCard,
      idCardType: idCardType,
      agreement: agreement,
      fields: fields?.asMap().map((key, value) => MapEntry(value.id, value)),
      preFilled: preFilled,
      type: type,
      id: objectId,
    );
  }
}
