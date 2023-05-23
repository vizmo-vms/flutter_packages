import 'package:flutter/foundation.dart' show describeEnum;
import 'package:get/state_manager.dart';
import 'package:rrule/rrule.dart';

import 'package:vizmo_models/utils/extension_utils.dart';
import 'package:vizmo_models/utils/utils.dart';
import 'package:vizmo_models/models/attendee.dart';
import 'package:vizmo_models/models/checkin_field.dart';
import 'package:vizmo_models/models/host.dart';
import 'package:collection/collection.dart';
import 'accept_reject.dart';
import 'approval.dart';
import 'enum.dart';

final doNotRepeat = 'Do not repeat';
final daily = 'Daily';
final weekdays = 'Every weekday (Monday to Friday)';
final weekday = 'Weekly on';
final custom = 'Custom';
final daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

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
  ///TODO: Convert this to ParseFile
  String? photoUri;

  ///
  /// Host can be same as createdBy
  /// used as organizer in ical.
  ///
  ///
  Host? host;

  ///
  /// Visitor type name
  /// not present incase only internal attendees are chosen
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
  /// not present incase only internal attendees are chosen
  ///
  String? visitorTypeKey;

  ///
  /// internal attendees
  /// key for the record will be auto-generated
  ///
  Map<String, Attendee>? attendees;

  ///
  /// recurrence
  ///
  Recurrence? recurrence;

  InviteSource? source;

  ///
  /// approval for invites
  /// need to notify attendees when approved
  ///
  Approval? approval;
  AcceptReject? acceptReject;

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
    this.acceptReject,
  });

  bool get isGroupInvite => (attendeeList.length) > 1;

  List<Attendee> get attendeeList => attendees?.values.toList() ?? [];

  bool isValidInvite({String? inviteId, String? phone, String? email}) {
    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);
    if (this.recurrence?.range?.endDate?.isBefore(date) ?? false) return false;

    if (this.recurrence?.isNotValidDay ?? false) return false;

    final _invitee =
        this.getAttendee(attendeeId: inviteId, phone: phone, email: email);

    // if (_invitee?.healthDeclaration?.isNotApproved ?? false) return false;
//TODO:Needs to be reviewed!!!!
    // if (!(this
    //         .recurrence
    //         ?.validNumberOfOccurrences(_invitee?.numberOfOccurrences ?? 0) ??
    //     true)) return false;
    return true;
  }

  bool isNotExpired() {
    if ((this.acceptReject?.required ?? false) &&
        this.acceptReject?.status != ApprovalStatus.accepted) return false;

    if (!(this.recurrence?.range?.startDate?.currentDay() ?? false)) {
      if (this.approval?.status == ApprovalStatus.rejected) return false;
    }

    final today = DateTime.now();
    final date = DateTime(today.year, today.month, today.day);
    if (this.recurrence?.range?.endDate?.isBefore(date) ?? false) return false;

    return true;
  }

  bool isInternalAttendee({String? attendeeId, String? phone, String? email}) {
    if (attendeeId != null) {
      return this.attendees?[attendeeId]?.internal ?? false;
    } else
      return this
              .attendees
              ?.values
              .firstWhereOrNull(
                  (element) => element.phone == phone || element.email == email)
              ?.internal ??
          false;
  }

  Attendee? getAttendee({String? attendeeId, String? phone, String? email}) {
    if ((attendeeId?.isEmpty ?? true) &&
        (phone?.isEmpty ?? true) &&
        ((email?.isEmpty ?? true))) return null;

    if (attendeeId != null) {
      return this.attendees?[attendeeId];
    } else
      return this.attendees?.values.firstWhereOrNull((element) =>
          ((phone?.isNotEmpty ?? false) && element.phone == phone) ||
          (((email?.isNotEmpty ?? false)) && element.email == email));
  }

  Attendee? getIndividualAttendee() {
    if (this.isGroupInvite) return null;

    if (this.attendees?.isNotEmpty ?? false) {
      return this.attendees?.values.first;
    } else
      return null;
  }
}

class Recurrence {
  Pattern? pattern;
  Range? range;

  Recurrence({
    this.pattern,
    this.range,
  });
  bool validNumberOfOccurrences(int occurrences) {
    if (this.range?.type == RecurrenceRangeType.numbered) {
      return occurrences < (this.range?.numberOfOccurrences ?? 0);
    }

    return true;
  }

  @override
  String toString() {
    final _rrule10n = Utils.rruleL10nEn;
    if (_rrule10n != null) {
      final _text = this.rrule().toText(l10n: _rrule10n).replaceAllMapped(
            RegExp(r' \d+:\d+:\d+ (PM|AM)'),
            (match) => '',
          );
      return _text == 'Daily, once' ? doNotRepeat : _text;
    } else
      return '';
  }

  String? toText() {
    final _rrule10n = Utils.rruleL10nEn;
    if (_rrule10n != null) {
      return this.rrule().toString();
    }

    return null;
  }

  DateTime? get validDay {
    final _instances = _getRRuleInstances() ?? [];

    return _instances.firstWhereOrNull(
        (instance) => instance.calendarDate() == DateTime.now().calendarDate());
  }

  bool get isNotValidDay => validDay == null;

  DateTime? get nextValidDay {
    final _instances = _getRRuleInstances();

    return _instances
        ?.firstWhereOrNull((instance) =>
            instance.calendarDate() == DateTime.now().calendarDate() ||
            instance.calendarDate().isAfter(DateTime.now().calendarDate()))
        ?.calendarDate();
  }

  bool isValidOnDay(DateTime date) {
    final _instances = _getRRuleInstances();

    return _instances?.any((instance) =>
            instance.calendarDate().compareTo(date.calendarDate()) == 0) ??
        false;
  }

  Iterable<DateTime>? _getRRuleInstances() {
    DateTime _startDate = this.range?.startDate ?? DateTime.now().toUtc();
    DateTime? _endDate = this.range?.endDate;

    // if (this.range?.numberOfOccurrences == 1) {
    //   return [_startDate.toLocal()];
    // } else if (_startDate.calendarDate() == _endDate?.calendarDate()) {
    //   return [_startDate.toLocal()];
    // }

    final _rrule = rrule();
    return _rrule
        .getInstances(
          start: _startDate.isUtc ? _startDate : _startDate.toUtc(),
          after: _startDate.isUtc ? _startDate : _startDate.toUtc(),
          before: _endDate?.isUtc ?? true ? _endDate : _endDate?.toUtc(),
          includeBefore: true,
          includeAfter: true,
        )
        .map((e) => e.toLocal());
  }

  RecurrenceRule rrule() {
    Frequency _frequency;
    Set<ByWeekDayEntry> _byWeekDays = Set();
    int? _interval;
    int? _count;
    DateTime? _until;
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
    _interval = this.pattern?.interval;

    // if (this.range?.endDate != null) {
    //   _until = this.range?.endDate?.isUtc ?? false
    //       ? this.range?.endDate
    //       : this.range?.endDate?.toUtc();
    // } else {
    switch (this.range?.type) {
      case RecurrenceRangeType.numbered:
        _count = this.range?.numberOfOccurrences;
        break;
      case RecurrenceRangeType.endDate:
        _until = this.range?.endDate?.isUtc ?? false
            ? this.range?.endDate
            : this.range?.endDate?.toUtc();
        break;
      default:
        break;
    }
    // }

    return RecurrenceRule(
      frequency: _frequency,
      byWeekDays: _byWeekDays,
      interval: _interval,
      count: _count,
      until: _until,
    );
  }

  List<DateTime> getValidDates() {
    final _instances = _getRRuleInstances();

    return _instances?.toList() ?? [];
  }

  Map<String, dynamic> toMap() {
    return {
      'pattern': pattern?.toMap(),
      'range': range?.toMap(),
    };
  }

  Map<String, dynamic> toJson({bool showTime: false}) {
    // if (range?.type == RecurrenceRangeType.numbered) {
    //   range?.endDate = lastValidDay ?? range?.endDate;
    // }
    return {
      'pattern': pattern?.toMap(),
      'range': range?.toJson(showTime: showTime),
    };
  }

  Map<String, dynamic> toJsonObject({bool showTime: false}) {
    return {
      'pattern': pattern?.toMap(),
      'range': range?.toJsonObject(showTime: showTime),
    };
  }

  factory Recurrence.fromMap(
    Map<String, dynamic> map,
  ) {
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
      'startDate': startDate,
      'numberOfOccurrences': numberOfOccurrences,
      'endDate': endDate,
    };
  }

  Map<String, dynamic> toJson({bool showTime: false}) {
    return {
      'type': type != null ? describeEnum(type!) : null,
      'startDate': showTime
          ? startDate?.toUtc().toIso8601String()
          : startDate?.toUtc().calendarDate().toIso8601String(),
      'numberOfOccurrences': numberOfOccurrences,
      'endDate': showTime
          ? endDate?.toUtc().toIso8601String()
          : endDate?.toUtc().calendarDate().toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }

  Map<String, dynamic> toJsonObject({bool showTime: false}) {
    return {
      'type': type != null ? describeEnum(type!) : null,
      'startDate': startDate,
      'numberOfOccurrences': numberOfOccurrences,
      'endDate': endDate,
    }..removeWhere((key, value) => value == null);
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
