import 'package:flutter/foundation.dart' show describeEnum;
import 'package:get/state_manager.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rrule/rrule.dart';
import 'package:vizmo_models/models/parse_schemas/visitor_type_schema.dart';
import 'package:vizmo_models/utils/extension_utils.dart';

import '../attendee.dart';
import '../enum.dart';
import '../invite.dart';
import 'attendee_schema.dart';
import 'company_schema.dart';
import 'employee_schema.dart';
import 'location_schema.dart';
import 'models.dart';

class InviteSchema extends ParseObject {
  InviteSchema({ParseHTTPClient? client}) : super(_className, client: client);

  static InviteSchema fromObject(ParseObject object) {
    final InviteSchema _object =
        InviteSchema().fromJson(object.toJson(full: true));
    // TODO:
    // bug in parse sdk,  parse_encode.dart file, while encoding object, if value is List, sdk is calling parseEncode(value); but full field is missing here
    _object.forApiRQ = false;
    _object.attendees =
        List.from(object.get<List>(attendeesKey) ?? []).map((result) {
      if (result is ParseObject) {
        return AttendeeSchema()..fromJson(result.toJson(full: true));
      }
      return AttendeeSchema()..fromJson(result);
    }).toList();
    _object.forApiRQ = true;
    return _object;
  }

  static const String _className = "Invite";

  static String companyKey = 'company';
  static String locationKey = 'location';
  static String titleKey = 'title';
  static String descriptionKey = 'description';
  static String commentsKey = 'comments';
  static String createdByKey = 'createdBy';
  static String sourceKey = 'source';
  static String visitorTypeKey = 'visitorType';
  static String recurrenceKey = 'recurrence';
  static String hostKey = 'host';
  static String attendeesKey = 'attendees';
  static String statusKey = 'status';
  static String acceptRejectKey = 'acceptReject';
  static String approvalKey = 'approval';
  static String endDateKey = 'recurrence.range.endDate';
  static String startDateKey = 'recurrence.range.startDate';

  bool forApiRQ = true;
  static String hostEmailKey = 'host.email';
  static String hostidKey = 'host.id';
  static String createdByEmailKey = 'createdBy.email';

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

  //TODO: add max 150 char limit, also add char limit to other fields in other classes as well
  String? get title => get<String>(titleKey);

  set title(String? title) => set<String?>(titleKey, title);

  String? get description => get<String?>(descriptionKey);

  set description(String? description) =>
      set<String?>(descriptionKey, description); //z.string().nullish(),

  String? get comments => get<String?>(commentsKey);

  set comments(String? comments) =>
      set<String?>(commentsKey, comments); //z.string().nullish(),

  ParseHost? get createdBy {
    final _host = get<Map<String, dynamic>>(createdByKey);
    if (_host == null) return null;
    return ParseHost.fromMap(_host);
  }

  set createdBy(ParseHost? createdBy) =>
      set<Map<String, dynamic>?>(createdByKey, createdBy?.toMap());

  SourceEnum? get source =>
      stringToEnum<SourceEnum>(SourceEnum.values, get<String>(sourceKey));

  set source(SourceEnum? value) =>
      set<String>(sourceKey, describeEnum(value ?? SourceEnum.kiosk));

  ParseVisitorType? get visitorType =>
      ParseVisitorType.fromMap(get<Map<String, dynamic>>(visitorTypeKey) ?? {});

  set visitorType(ParseVisitorType? type) =>
      set<Map<String, dynamic>?>(visitorTypeKey, type?.toMap());

  Recurrence? get recurrence =>
      Recurrence.fromMap(get<Map<String, dynamic>>(recurrenceKey) ?? {});

  set recurrence(Recurrence? recurrence) =>
      set<Map<String, dynamic>?>(recurrenceKey, recurrence?.toMap());

  //hostSchema.nullish().default(null),
  ParseHost? get host {
    final _host = get<Map<String, dynamic>>(hostKey);
    if (_host == null) return null;
    return ParseHost.fromMap(_host);
  }

  set host(ParseHost? host) =>
      set<Map<String, dynamic>?>(hostKey, host?.toMap());

  List<AttendeeSchema>? get attendees =>
      List.from(get<List>(attendeesKey) ?? []).map((result) {
        if (result is ParseObject) {
          return AttendeeSchema()..fromJson(result.toJson(full: true));
        }
        return AttendeeSchema()..fromJson(result);
      }).toList();

  set attendees(List<AttendeeSchema>? attendees) => set<List>(
      attendeesKey,
      attendees
              ?.map((e) => (e.objectId?.isNotEmpty ?? false)
                  ? e.toPointer()
                  : e.toJson(full: true, forApiRQ: true))
              .toList() ??
          []);

  InviteStatus? get status =>
      stringToEnum<InviteStatus>(InviteStatus.values, get<String>(statusKey));

  set status(InviteStatus? status) =>
      set<String>(statusKey, describeEnum(status!));

  ParseAcceptReject? get acceptReject {
    if (get<Map<String, dynamic>>(acceptRejectKey) == null) return null;
    return ParseAcceptReject.fromMap(
        get<Map<String, dynamic>>(acceptRejectKey) ?? {});
  }

  set acceptReject(ParseAcceptReject? acceptReject) =>
      set<Map<String, dynamic>?>(acceptRejectKey, acceptReject?.toMap());

  ParseApproval? get approval {
    if (get<Map<String, dynamic>>(approvalKey) == null) return null;
    return ParseApproval.fromMap(get<Map<String, dynamic>>(approvalKey) ?? {});
  }

  set approval(ParseApproval? approval) =>
      set<Map<String, dynamic>?>(approvalKey, approval?.toMap());

  Invite toInvite() {
    final inviteesEmail = this
            .attendees
            ?.where((e) => e.email != null && e.email!.isNotEmpty)
            .map((e) => e.email!)
            .toList() ??
        [];

    final inviteesPhone = this
            .attendees
            ?.where((e) => e.email != null && e.email!.isNotEmpty)
            .map((e) => e.email!)
            .toList() ??
        [];

    return Invite(
      key: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      approval: this.approval?.toApproval(),
      comments: this.comments,
      createdAt: this.createdAt,
      createdBy: this.createdBy?.toHost(),
      description: this.description,
      emails: inviteesEmail,
      attendees: this
          .attendees
          ?.asMap()
          .map((key, value) => MapEntry(value.objectId!, value.toAttendee())),
      host: this.host?.toHost(),
      phoneNumbers: inviteesPhone,
      recurrence: this.recurrence,
      title: this.title,
      visitorTypeKey: this.visitorType?.pointer?.objectId,
      visitorType: this.visitorType?.name,
      visitorTypeDisplayName: this.visitorType?.displayName,
    );
  }

  Future<void> fromInvite(
      Invite data, String cid, String lid, List<Attendee> attendees) async {
    this.company = CompanySchema()..objectId = cid;
    this.location = LocationSchema()..objectId = lid;

    this.title = data.title ?? '${data.visitorTypeDisplayName} invite';
    this.description = data.description;
    this.comments = data.comments;

    // Invite update
    // for invite update save attendees before updating invite
    if (data.key?.isNotEmpty ?? false) {
      final _futures = attendees.map((e) async {
        if (e.id?.isEmpty ?? true) {
          final _schema = AttendeeSchema()
            ..company = this.company
            ..location = this.location
            ..firstName = e.firstName
            ..lastName = e.lastName
            ..email = e.email
            ..phone = e.phone
            ..companyName = e.companyName
            ..photo = e.photo
            ..type = e.type;

          final _res = await _schema.save();
          if (_res.success) {
            if (_res.result != null) {
              return AttendeeSchema()..objectId = _res.result.objectId;
            } else if (_res.results?.isNotEmpty ?? false) {
              return AttendeeSchema()..objectId = _res.results?.first.objectId;
            }
          }
          throw _res.error ??
              'Error saving attendee ${e.firstName} ${e.lastName}';
        } else
          return AttendeeSchema()..objectId = e.id;
      }).toList();

      this.attendees = await Future.wait(_futures);
      return;
    }

    // for invite create send attendee as json
    this.attendees = attendees
        .map((e) => AttendeeSchema()
          ..company = this.company
          ..location = this.location
          ..firstName = e.firstName
          ..lastName = e.lastName
          ..email = e.email
          ..phone = e.phone
          ..companyName = e.companyName
          ..photo = e.photo
          ..type = e.type)
        .toList();

    this.createdBy = ParseHost.fromHost(data.createdBy!);
    this.source = SourceEnum.vizmopass;

    this.visitorType = ParseVisitorType(
      pointer: VisitorTypeSchema()..objectId = data.visitorTypeKey,
      name: data.visitorType,
      displayName: data.visitorTypeDisplayName,
    );

    this.host = data.host != null
        ? ParseHost(
            pointer: EmployeeSchema()..objectId = data.host?.uid,
            name: data.host?.name,
            email: data.host?.email,
          )
        : null;

    this.recurrence = data.recurrence;
  }
}
