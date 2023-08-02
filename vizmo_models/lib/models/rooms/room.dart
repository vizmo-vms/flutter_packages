// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../desk_booking/floor.dart';
import '../desk_booking/zone.dart';
import '../parse_schemas/rooms/room_schema.dart';
import 'amenities.dart';

class Room {
  final String? id;
  final String? cid;
  final String? lid;
  final String? name;
  final String? description;
  final ParseZone? zone;
  final Floor? floor;
  final bool enabled;
  final ParseGeoPoint? position;
  final int? minBookingDuration;
  final int? maxBookingDuration;
  final int? capacity;
  final List<ParseFile?> photos;
  final List<Amenities?> amenities;
  final Availability? availability;

  // not in database
  bool booked = false;
  Room(
      {this.id,
      this.cid,
      this.lid,
      this.name,
      this.description,
      this.zone,
      this.floor,
      required this.enabled,
      this.position,
      this.minBookingDuration,
      this.maxBookingDuration,
      this.capacity,
      required this.photos,
      required this.amenities,
      required this.availability});
}
