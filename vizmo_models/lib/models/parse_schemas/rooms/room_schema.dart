// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../invite.dart';
import '../../rooms/room.dart';
import '../company_schema.dart';
import '../desk_booking/floor_schema.dart';
import '../desk_booking/zone_schema.dart';
import '../location_schema.dart';
import 'amenities_schema.dart';

class RoomSchema extends ParseObject {
  RoomSchema({ParseHTTPClient? client}) : super(_className, client: client);
  static RoomSchema fromObject(ParseObject object) {
    return RoomSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "Room";
  static String companyKey = 'company';
  static String locationKey = 'location';
  static String nameKey = 'name'; //TODO: max 50
  static String descriptionKey = 'description'; //TODO: max 300
  static String floorKey = 'floor';
  static String zoneKey = 'zone';
  static String capacityKey = 'capacity';
  static String availabilityKey = 'availability';
  static String minBookingDurationKey = 'minBookingDuration';
  static String maxBookingDurationKey = 'maxBookingDuration';
  static String amenitiesKey = 'amenities';
  static String photosKey = 'photos';
  static String enabledKey = 'enabled';
  static String positionKey = 'position';
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

  FloorSchema? get floor {
    var result = get(floorKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return FloorSchema()..fromJson(result.toJson(full: true));
    }
    return FloorSchema()..fromJson(result);
  }

  ZoneSchema? get zone {
    var result = get(zoneKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return ZoneSchema()..fromJson(result.toJson(full: true));
    }
    return ZoneSchema()..fromJson(result);
  }

  set company(CompanySchema? company) => set(companyKey, company?.toPointer());

  set location(LocationSchema? value) => set(locationKey, value?.toPointer());

  String? get name => get<String?>(nameKey);

  String? get description => get<String?>(descriptionKey);

  bool get enabled => get<bool?>(enabledKey) ?? false;

  ParseGeoPoint? get position => get<ParseGeoPoint>(positionKey);

  int? get capacity => get<int?>(capacityKey);

  Availability? get availability {
    var result = get<Map<String, dynamic>>(availabilityKey);
    if (result != null) return Availability.fromMap(result);
  }

  int? get minBookingDuration => get<int?>(minBookingDurationKey);
  int? get maxBookingDuration => get<int?>(maxBookingDurationKey);

  set minBookingDuration(int? value) => set(minBookingDurationKey, value);
  set maxBookingDuration(int? value) => set(maxBookingDurationKey, value);

  List<ParseFile>? get photos =>
      get<List<dynamic>?>(photosKey)?.map((e) => e as ParseFile).toList();
  set photos(List<ParseFile>? value) => set(photosKey, value);
  List<AmenitiesSchema>? get amenities {
    var result = get(amenitiesKey);
    if (result == null) return null;
    return (result as List).map((e) {
      if (e is ParseObject) {
        return AmenitiesSchema()..fromJson(e.toJson(full: true));
      }
      return AmenitiesSchema()..fromJson(e);
    }).toList();
  }

  Room toRoom({Room? room}) {
    return Room(
      id: this.objectId ?? room?.id,
      capacity: this.capacity ?? room?.capacity,
      cid: this.company?.objectId ?? room?.cid,
      lid: this.location?.objectId ?? room?.lid,
      name: this.name ?? room?.name,
      description: this.description ?? room?.description,
      enabled: this.enabled,
      floor: this.floor?.toFloor() ?? room?.floor,
      zone: this.zone?.toZone() ?? room?.zone,
      position: this.position ?? room?.position,
      photos: this.photos ?? [],
      availability: this.availability ?? room?.availability,
      amenities: this.amenities != null
          ? this.amenities!.map((e) => e.toAmenities()).toList()
          : [],
      minBookingDuration: this.minBookingDuration ?? room?.minBookingDuration,
      maxBookingDuration: this.maxBookingDuration ?? room?.maxBookingDuration,
    );
  }
}

class RoomRecurrence extends Recurrence {
  List<Recurrence> exRules;
  RoomRecurrence(
      {Pattern? pattern,
      Range? range,
      required this.exRules,
      DateTime? nextOccurrenceAt})
      : super(
            range: range, pattern: pattern, nextOccurrenceAt: nextOccurrenceAt);
  factory RoomRecurrence.fromMap(
      Map<String, dynamic> map, DateTime? nextOccurrenceAt) {
    return RoomRecurrence(
      exRules: map['exRules'] == null
          ? []
          : (map['exRules'] as List)
              .map<Recurrence>((e) => Recurrence.fromMap(e, nextOccurrenceAt))
              .toList(),
      pattern: Pattern.fromMap(map['pattern']),
      range: Range.fromMap(map['range']),
      nextOccurrenceAt: nextOccurrenceAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pattern': pattern?.toMap(),
      'range': range?.toMap(),
      if (exRules.isNotEmpty) 'exRules': exRules.map((e) => e.toMap()).toList()
    };
  }
}

class AvailabilityPattern {
  String? openAt;
  String? closeAt;
  bool? isOpen24Hours;
  AvailabilityPattern({
    this.openAt,
    this.closeAt,
    this.isOpen24Hours,
  });

  AvailabilityPattern copyWith({
    String? openAt,
    String? closeAt,
    bool? isOpen24Hours,
  }) {
    return AvailabilityPattern(
      openAt: openAt ?? this.openAt,
      closeAt: closeAt ?? this.closeAt,
      isOpen24Hours: isOpen24Hours ?? this.isOpen24Hours,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'openAt': openAt,
      'closeAt': closeAt,
      'isOpen24Hours': isOpen24Hours,
    };
  }

  factory AvailabilityPattern.fromMap(Map<String, dynamic> map) {
    return AvailabilityPattern(
      openAt: map['openAt'] != null ? map['openAt'] as String : null,
      closeAt: map['closeAt'] != null ? map['closeAt'] as String : null,
      isOpen24Hours:
          map['isOpen24Hours'] != null ? map['isOpen24Hours'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailabilityPattern.fromJson(String source) =>
      AvailabilityPattern.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AvailabilityPattern(openAt: $openAt, closeAt: $closeAt, isOpen24Hours: $isOpen24Hours)';

  @override
  bool operator ==(covariant AvailabilityPattern other) {
    if (identical(this, other)) return true;

    return other.openAt == openAt &&
        other.closeAt == closeAt &&
        other.isOpen24Hours == isOpen24Hours;
  }

  @override
  int get hashCode =>
      openAt.hashCode ^ closeAt.hashCode ^ isOpen24Hours.hashCode;
}

class AvailabilityExRules {
  Recurrence? recurrence;
  int? duration;
  AvailabilityExRules({
    this.recurrence,
    this.duration,
  });

  AvailabilityExRules copyWith({
    Recurrence? recurrence,
    int? duration,
  }) {
    return AvailabilityExRules(
      recurrence: recurrence ?? this.recurrence,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recurrence': recurrence?.toMap(),
      'duration': duration,
    };
  }

  factory AvailabilityExRules.fromMap(Map<String, dynamic> map) {
    return AvailabilityExRules(
      recurrence: map['recurrence'] != null
          ? Recurrence.fromMap(map['recurrence'] as Map<String, dynamic>, null)
          : null,
      duration: map['duration'] != null ? map['duration'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailabilityExRules.fromJson(String source) =>
      AvailabilityExRules.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AvailabilityExRules(recurrence: $recurrence, duration: $duration)';

  @override
  bool operator ==(covariant AvailabilityExRules other) {
    if (identical(this, other)) return true;

    return other.recurrence == recurrence && other.duration == duration;
  }

  @override
  int get hashCode => recurrence.hashCode ^ duration.hashCode;
}

class Availability {
  AvailabilityPattern? pattern;
  List<AvailabilityExRules>? exRules;
  List<int>? daysOfWeek;
  Availability({this.pattern, this.daysOfWeek, this.exRules});

  factory Availability.fromMap(Map<String, dynamic> map) {
    return Availability(
        daysOfWeek: map['daysOfWeek'] != null
            ? (map['daysOfWeek'] as List).map((e) => e as int).toList()
            : null,
        pattern: AvailabilityPattern.fromMap(map['pattern']),
        exRules: map['exRules'] == null
            ? []
            : (map['exRules'] as List)
                .map((e) => AvailabilityExRules.fromMap(e))
                .toList());
  }
}
