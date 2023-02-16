import 'package:vizmo_pass/app/data/models/desk_booking/floor.dart';

class DeskZone {
  final String? id;
  final String? cid;
  final String? lid;
  final String? name;
  final List<Floor> floors;

  DeskZone({
    this.id,
    this.cid,
    this.lid,
    this.name,
    this.floors: const [],
  });
}
