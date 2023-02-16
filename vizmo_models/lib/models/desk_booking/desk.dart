import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_pass/app/data/models/desk_booking/floor.dart';
import 'package:vizmo_pass/app/data/models/desk_booking/zone.dart';

class Desk {
  final String? id;
  final String? cid;
  final String? lid;
  final String? name;
  final String? description;
  final DeskZone? zone;
  final Floor? floor;
  final bool enabled;
  final ParseGeoPoint? position;

  // not in database
  bool booked = false;

  Desk({
    this.id,
    this.cid,
    this.lid,
    this.name,
    this.description,
    this.zone,
    this.floor,
    this.enabled: false,
    this.position,
  });
}
