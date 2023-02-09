import 'package:flutter/foundation.dart';
import 'package:rrule/rrule.dart';
import 'package:vizmo_models/models/attendee.dart';
import 'package:vizmo_models/models/checkin_field.dart';
import 'package:vizmo_models/models/host.dart';
import 'package:vizmo_models/utils/extension_utils.dart';
import 'package:collection/collection.dart';
import 'package:vizmo_models/utils/utils.dart';
import 'approval.dart';
import 'enum.dart';

class Invite {
  String? key;

  ///
  /// invite title can be used for subject line
  ///
  String? title;

  ///
  /// invite description can be used as premises guidelines set by admin.
  ///
  String? description;

  ///
  ///
  ///
  String? comments;

  ///
  /// invite createdAt
  ///
  DateTime? createdAt;

  ///
  /// Person who created Invite
  ///
  Host? createdBy;

  ///
  /// Photo download url
  ///
  String? photoUri;

  ///
  /// Host can be same as createdBy
  /// used as organizer in ical.
  ///
  ///
  Host? host;

  ///
  /// Visitor type name
  /// not present incase only internal invitees are chosen
  ///
  String? visitorType;

  ///
  /// Visitor type display name
  /// same as [visitorType] for firebase
  ///
  String? visitorTypeDisplayName;

  ///
  /// visitor type id
  /// firebase: visitorType.name
  /// parse: visitorType.objectId
  /// not present incase only internal invitees are chosen
  ///
  String? visitorTypeKey;

  ///
  /// internal invitees
  /// key for the record will be auto-generated
  ///
  Map<String, Attendee?>? attendees;

  ///
  /// recurrence
  ///
  Recurrence? recurrence;

  InviteSource? source;

  ///
  /// approval for invites
  /// need to notify invitees when approved
  ///
  Approval? approval;

  ///
  /// for backward compatibility
  ///
  // bool preFilled;
  ///
  /// for backward compatibility
  ///
  // DateTime expectedAt;
  ///
  /// for backward compatibility
  ///
  // DateTime expiresAt;

  Map<String, CheckinField>? fields;

  String? logId;
  List<String>? phoneNumbers;
  List<String>? emails;
  String? cid;
  String? lid;
  Invite({
    this.key,
    this.title,
    this.description,
    this.comments,
    this.createdAt,
    this.createdBy,
    this.photoUri,
    this.host,
    this.visitorType,
    this.visitorTypeKey,
    this.attendees,
    this.recurrence,
    this.approval,
    this.fields,
    this.logId,
    this.phoneNumbers,
    this.emails,
    this.visitorTypeDisplayName,
    this.cid,
    this.lid,
  });

  bool isValidInvite({String? inviteId, String? phone, String? email}) {
    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);
    if (this.recurrence?.range?.endDate?.isBefore(date) ?? false) return false;

    if (this.recurrence?.isNotValidDay ?? false) return false;

    final _invitee =
        this.getAttendee(inviteeId: inviteId, phone: phone, email: email);

    // if (_invitee?.healthDeclaration?.isNotApproved ?? false) return false;

    if (!(this
            .recurrence
            ?.validNumberOfOccurrences(_invitee?.numberOfOccurrences ?? 0) ??
        true)) return false;

    return true;
  }

  bool isInternalInvitee({String? inviteeId, String? phone, String? email}) {
    if (inviteeId != null) {
      return this.attendees![inviteeId] != null;
    } else
      return this.attendees?.values.firstWhereOrNull((element) =>
              element?.phone == phone || element?.email == email) !=
          null;
  }

  Attendee? getAttendee({String? inviteeId, String? phone, String? email}) {
    if ((inviteeId?.isEmpty ?? true) &&
        (phone?.isEmpty ?? true) &&
        ((email?.isEmpty ?? true))) return null;

    if (inviteeId != null) {
      return this.attendees![inviteeId];
    } else
      return this.attendees?.values.firstWhereOrNull((element) =>
          ((phone?.isNotEmpty ?? false) && element?.phone == phone) ||
          (((email?.isNotEmpty ?? false)) && element?.email == email));
  }
}

class Recurrence {
  Pattern? pattern;
  Range? range;
  Recurrence({
    this.pattern,
    this.range,
  });

  DateTime? get validDay {
    final _instances = _getRRuleInstances() ?? [];

    return _instances.firstWhereOrNull((instance) =>
        instance?.calendarDate() == DateTime.now().calendarDate());
  }

  bool validNumberOfOccurrences(int occurrences) {
    if (this.range?.type == RecurrenceRangeType.numbered) {
      return occurrences < (this.range?.numberOfOccurrences ?? 0);
    }

    return true;
  }

  bool get isNotValidDay => validDay == null;

  DateTime? get nextValidDay {
    final _instances = _getRRuleInstances();

    return _instances
        ?.firstWhereOrNull((instance) =>
            instance?.calendarDate().isAfter(DateTime.now().calendarDate()) ??
            false)
        ?.calendarDate();
  }

  Iterable<DateTime?>? _getRRuleInstances() {
    Frequency _frequency;
    Set<ByWeekDayEntry> _byWeekDays = Set();
    int? _interval;
    int? _count;
    DateTime? _until;
    DateTime _startDate;
    final _weeks = [
      DateTime.sunday,
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday
    ];
    switch (this.pattern?.type) {
      case RecurrencePatternType.week:
        _frequency = Frequency.weekly;
        this.pattern?.daysOfWeek?.forEach((i) {
          _byWeekDays.add(ByWeekDayEntry(_weeks[i]));
        });
        break;
      case RecurrencePatternType.day:
      default:
        _frequency = Frequency.daily;
        break;
    }
    _interval = this.pattern?.interval ?? 1;

    switch (this.range?.type) {
      case RecurrenceRangeType.numbered:
        _count = this.range?.numberOfOccurrences;
        break;
      case RecurrenceRangeType.endDate:
        _until = this.range?.endDate;
        break;
      default:
        break;
    }

    _startDate = this.range?.startDate ?? DateTime.now().toUtc();

    return RecurrenceRule(
      frequency: _frequency,
      byWeekDays: _byWeekDays,
      interval: _interval,
      count: _count,
      until: _until,
    )
        .getInstances(start: _startDate.isUtc ? _startDate : _startDate.toUtc())
        .map((e) => e.toLocal().calendarDate());
  }

  Map<String, dynamic> toMap() {
    return {
      'pattern': pattern?.toMap(),
      'range': range?.toMap(),
    };
  }

  factory Recurrence.fromMap(Map<String, dynamic> map) {
    return Recurrence(
      pattern: Pattern.fromMap(map['pattern']),
      range: Range.fromMap(map['range']),
    );
  }
}

class Pattern {
  RecurrencePatternType? type;

  int? interval;

  ///
  /// valid only incase of weekly pattern.
  ////// 0 -> Sunday
  ////// 6 -> Saturday
  ///
  /// ex: [0,3] -> Sunday and Wednesday
  ///
  List<int>? daysOfWeek;
  Pattern({
    this.type,
    this.interval,
    this.daysOfWeek,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type != null ? describeEnum(type!) : null,
      'interval': interval,
      'daysOfWeek': daysOfWeek,
    };
  }

  factory Pattern.fromMap(Map<String, dynamic> map) {
    return Pattern(
      type: stringToEnum(RecurrencePatternType.values, map['type']),
      interval: map['interval'],
      daysOfWeek: List<int>.from(map['daysOfWeek'] ?? []),
    );
  }
}

class Range {
  RecurrenceRangeType? type;
  DateTime? startDate;

  ///
  /// valid incase of numbered type
  /// need to set number of occurrence as 1.
  ///
  int? numberOfOccurrences;

  ///
  /// valid incase of endDate type
  ///
  DateTime? endDate;
  Range({
    this.type,
    this.startDate,
    this.numberOfOccurrences: 0,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type != null ? describeEnum(type!) : null,
      'startDate': startDate?.millisecondsSinceEpoch,
      'numberOfOccurrences': numberOfOccurrences,
      'endDate': endDate?.millisecondsSinceEpoch,
    };
  }

  factory Range.fromMap(Map<String, dynamic> map) {
    return Range(
      type: stringToEnum(RecurrenceRangeType.values, map['type']),
      startDate: Utils.parseDate(map['startDate']),
      numberOfOccurrences: map['numberOfOccurrences'] ?? 0,
      endDate: Utils.parseDate(map['endDate']),
    );
  }
}
