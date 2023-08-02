// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/parse_schemas/rooms/room_schema.dart';

import '../../../../utils/extension_utils.dart';
import '../../../../utils/utils.dart';
import '../../desk_booking/floor.dart';
import '../../desk_booking/zone.dart';
import '../../rooms/room.dart';
import '../../rooms/room_booking.dart';
import '../company_schema.dart';
import '../desk_booking/enum.dart';
import '../invite_schema.dart';
import '../location_schema.dart';
import '../models.dart';
import 'enum.dart';

class RoomBookingSchema extends ParseObject {
  RoomBookingSchema({ParseHTTPClient? client})
      : super(_className, client: client);

  static const String _className = 'RoomBooking';
  static RoomBookingSchema fromObject(ParseObject object) {
    return RoomBookingSchema().fromJson(object.toJson(full: true));
  }

  static String companyKey = 'company';
  static String locationKey = 'location';
  static String roomKey = 'room';
  static String recurrenceKey = 'recurrence';
  static String createdByKey = 'createdBy';
  static String durationKey = 'duration';
  static String inviteKey = 'invite';
  static String statusKey = 'status';
  static String nextOccurrenceAtKey = "nextOccurrenceAt";

  static String roomPointerKey = 'room.pointer';
  static String startDate = 'recurrence.range.startDate';
  static String endDate = 'recurrence.range.endDate';

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
  ParseRoomPointer? get room {
    var result = get<Map<String, dynamic>>(roomKey);
    if (result != null) return ParseRoomPointer.fromMap(result);
  }

  set room(ParseRoomPointer? value) => set(roomKey, value?.toMap());

  ParseHost? get createdBy {
    var result = get<Map<String, dynamic>>(createdByKey);
    if (result != null) return ParseHost.fromMap(result);
  }

  set createdBy(ParseHost? value) => set(createdByKey, value?.toMap());

  int? get duration => get<int?>(durationKey);
  set duration(int? value) => set(durationKey, value);

  RoomBookingStatus? get status =>
      stringToEnum(RoomBookingStatus.values, get<String>(statusKey));

  set status(RoomBookingStatus? value) =>
      set<String?>(statusKey, value != null ? describeEnum(value) : null);

  DateTime? get nextOccurrenceAt => Utils.getDateTime(get(nextOccurrenceAtKey));

  RoomRecurrence get recurrence => RoomRecurrence.fromMap(
      get<Map<String, dynamic>>(recurrenceKey) ?? {}, this.nextOccurrenceAt);
  set recurrence(RoomRecurrence? recurrence) =>
      set<Map<String, dynamic>?>(recurrenceKey, recurrence?.toMap());

  InviteSchema? get invite {
    var result = get(inviteKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return InviteSchema()..fromJson(result.toJson(full: true));
    }

    return InviteSchema()..fromJson(result);
  }

  set invite(InviteSchema? data) => set(inviteKey, data?.toPointer());

  RoomBooking toRoomBooking({Room? room}) {
    return RoomBooking(
      id: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      room: this.room?.toRoom(roomData: room),
      invite: this.invite?.toInvite(),
      duration: this.duration,
      createdBy: this.createdBy,
      recurrence: this.recurrence,
      status: this.status,
    );
  }

  void fromBooking(RoomBooking booking) {
    this.company = CompanySchema()..objectId = booking.cid;
    this.location = LocationSchema()..objectId = booking.lid;

    final _room = booking.room;
    this.room = ParseRoomPointer(
      room: RoomSchema()..objectId = _room?.id,
      name: _room?.name,
      floor: _room?.floor?.name,
      zone: _room?.zone?.name,
    );
    if (booking.invite != null) {
      this.invite = InviteSchema()
        ..fromInvite(booking.invite!, booking.cid!, booking.lid!, [])
        ..objectId = booking.invite?.key;
    }
    this.createdBy = booking.createdBy;
    this.recurrence = booking.recurrence;
    this.duration = booking.duration;
    // this.status = booking.status?? RoomBookingStatus.CONFIRMED;
    this.recurrence = booking.recurrence;
  }
}

class ParseRoomPointer {
  RoomSchema? room;

  String? name;
  String? floor;
  String? zone;
  ParseRoomPointer({
    this.room,
    this.name,
    this.floor,
    this.zone,
  });

  ParseRoomPointer copyWith({
    RoomSchema? room,
    String? name,
    String? floor,
    String? zone,
  }) {
    return ParseRoomPointer(
      room: room ?? this.room,
      name: name ?? this.name,
      floor: floor ?? this.floor,
      zone: zone ?? this.zone,
    );
  }

  toRoom({Room? roomData}) {
    if (this.room?.name == null) {
      return Room(
          enabled: true,
          id: room?.objectId,
          name: name,
          floor: Floor(name: floor),
          zone: ParseZone(name: zone),
          photos: [],
          amenities: [],
          availability: Availability());
    } else
      return this.room?.toRoom(room: roomData);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pointer': room?.toPointer(),
      'name': name,
      'floor': floor,
      'zone': zone,
    };
  }

  factory ParseRoomPointer.fromMap(Map<String, dynamic> map) {
    return ParseRoomPointer(
      room: map['pointer'] != null
          ? (map['pointer'] is ParseObject
              ? RoomSchema.fromObject(map['pointer'])
              : RoomSchema().fromJson(map['pointer']))
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      floor: map['floor'] != null ? map['floor'] as String : null,
      zone: map['zone'] != null ? map['zone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParseRoomPointer.fromJson(String source) =>
      ParseRoomPointer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomObject(room: $room, name: $name, floor: $floor, zone: $zone)';
  }

  @override
  bool operator ==(covariant ParseRoomPointer other) {
    if (identical(this, other)) return true;

    return other.room == room &&
        other.name == name &&
        other.floor == floor &&
        other.zone == zone;
  }

  @override
  int get hashCode {
    return room.hashCode ^ name.hashCode ^ floor.hashCode ^ zone.hashCode;
  }
}
