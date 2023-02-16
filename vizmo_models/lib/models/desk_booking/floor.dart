import 'package:vizmo_models/models/parse_schemas/desk_booking/models.dart';

class Floor {
  final String? id;
  final String? cid;
  final String? lid;
  final String? name;
  final String? description;
  final FloorLayout? layout;

  Floor({
    this.id,
    this.cid,
    this.lid,
    this.name,
    this.description,
    this.layout,
  });
}
