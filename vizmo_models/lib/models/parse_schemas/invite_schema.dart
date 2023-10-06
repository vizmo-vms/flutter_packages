import 'package:flutter/foundation.dart' show describeEnum;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/parse_schemas/visitor_type_schema.dart';
import 'package:vizmo_models/utils/extension_utils.dart';
import 'package:vizmo_models/utils/utils.dart';

import '../attendee.dart';
import '../enum.dart';
import '../invite.dart';
import 'attendee_schema.dart';
import 'company_schema.dart';
import 'employee_schema.dart';
import 'location_schema.dart';
import 'models.dart';

class InviteSchema extends ParseObject {
  InviteSchema({ParseClient? client}) : super(_className, client: client);

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
  static String nextOccurrenceAtKey = "nextOccurrenceAt";
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
  DateTime? get nextOccurrenceAt => Utils.getDateTime(get(nextOccurrenceAtKey));
  Recurrence? get recurrence => Recurrence.fromMap(
      get<Map<String, dynamic>>(recurrenceKey) ?? {}, nextOccurrenceAt);

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
              ?.map((e) => e.toJson(full: true, forApiRQ: forApiRQ))
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
    final inviteesEmail = attendees
            ?.where((e) => e.email != null && e.email!.isNotEmpty)
            .map((e) => e.email!)
            .toList() ??
        [];

    final inviteesPhone = attendees
            ?.where((e) => e.email != null && e.email!.isNotEmpty)
            .map((e) => e.email!)
            .toList() ??
        [];

    return Invite(
      key: objectId,
      cid: company?.objectId,
      lid: location?.objectId,
      approval: approval?.toApproval(),
      comments: comments,
      createdAt: createdAt,
      createdBy: createdBy?.toHost(),
      description: description,
      emails: inviteesEmail,
      attendees: attendees
          ?.asMap()
          .map((key, value) => MapEntry(value.objectId!, value.toAttendee())),
      host: host?.toHost(),
      phoneNumbers: inviteesPhone,
      recurrence: recurrence,
      title: title,
      visitorTypeKey: visitorType?.pointer?.objectId,
      visitorType: visitorType?.name,
      visitorTypeDisplayName: visitorType?.displayName,
    );
  }

  Future<void> fromInvite(
      Invite data, String cid, String lid, List<Attendee> attendees) async {
    company = CompanySchema()..objectId = cid;
    location = LocationSchema()..objectId = lid;

    title = data.title ?? '${data.visitorTypeDisplayName} invite';
    description = data.description;
    comments = data.comments;

    // Invite update
    // for invite update save attendees before updating invite
    if (data.key?.isNotEmpty ?? false) {
      final _futures = attendees.map((e) async {
        if (e.id?.isEmpty ?? true) {
          final _schema = AttendeeSchema()
            ..company = company
            ..location = location
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
          ..company = company
          ..location = location
          ..firstName = e.firstName
          ..lastName = e.lastName
          ..email = e.email
          ..phone = e.phone
          ..companyName = e.companyName
          ..photo = e.photo
          ..type = e.type)
        .toList();

    createdBy = ParseHost.fromHost(data.createdBy!);
    source = SourceEnum.vizmopass;
    if (data.visitorType != null)
      visitorType = ParseVisitorType(
        pointer: VisitorTypeSchema()..objectId = data.visitorTypeKey,
        name: data.visitorType,
        displayName: data.visitorTypeDisplayName,
      );

    host = data.host != null
        ? ParseHost(
            employee: EmployeeSchema()..objectId = data.host?.uid,
            name: data.host?.name,
            email: data.host?.email,
          )
        : null;

    recurrence = data.recurrence;
  }
}
