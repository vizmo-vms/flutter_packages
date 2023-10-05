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
  Floor copyWith({
    String? id,
    String? cid,
    String? lid,
    String? name,
    String? description,
    FloorLayout? layout,
  }) {
    return Floor(
      id: id ?? this.id,
      cid: cid ?? this.cid,
      lid: lid ?? this.lid,
      name: name ?? this.name,
      description: description ?? this.description,
      layout: layout ?? this.layout,
    );
  }
}
