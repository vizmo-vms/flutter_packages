// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../invite.dart';
import '../parse_schemas/models.dart';
import '../parse_schemas/rooms/enum.dart' show RoomBookingStatus;
import '../parse_schemas/rooms/room_schema.dart';
import 'room.dart';

class RoomBooking {
  String? id;
  final String? cid;
  final String? lid;
  Room? room;
  final RoomRecurrence? recurrence;
  final ParseHost? createdBy;
  final int? duration;
  final Invite? invite;
  RoomBookingStatus? status;
  RoomBooking({
    this.id,
    this.cid,
    this.lid,
    this.room,
    this.recurrence,
    this.createdBy,
    this.duration,
    this.invite,
    this.status,
  });

  bool get isCancelled => status == RoomBookingStatus.CANCELLED;
  RoomBooking copyWith({
    String? id,
    String? cid,
    String? lid,
    Room? room,
    RoomRecurrence? recurrence,
    ParseHost? createdBy,
    int? duration,
    Invite? invite,
    RoomBookingStatus? status,
  }) {
    return RoomBooking(
      id: id ?? this.id,
      cid: cid ?? this.cid,
      lid: lid ?? this.lid,
      room: room ?? this.room,
      recurrence: recurrence ?? this.recurrence,
      createdBy: createdBy ?? this.createdBy,
      duration: duration ?? this.duration,
      invite: invite ?? this.invite,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(covariant RoomBooking other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.cid == cid &&
        other.lid == lid &&
        other.room == room &&
        other.recurrence == recurrence &&
        other.createdBy == createdBy &&
        other.duration == duration &&
        other.invite == invite &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cid.hashCode ^
        lid.hashCode ^
        room.hashCode ^
        recurrence.hashCode ^
        createdBy.hashCode ^
        duration.hashCode ^
        invite.hashCode ^
        status.hashCode;
  }
}
