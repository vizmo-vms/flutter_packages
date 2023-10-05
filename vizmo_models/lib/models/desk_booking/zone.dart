import 'package:vizmo_models/models/desk_booking/floor.dart';

class ParseZone {
  final String? id;
  final String? cid;
  final String? lid;
  final String? name;
  final List<Floor> floors;

  ParseZone({
    this.id,
    this.cid,
    this.lid,
    this.name,
    this.floors = const [],
  });
}
