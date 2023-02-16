// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:vizmo_models/models/desk_booking/floor.dart';
import 'package:vizmo_models/models/desk_booking/zone.dart';

import 'package:vizmo_models/models/parse_schemas/desk_booking/desk_schema.dart';
import 'package:vizmo_models/models/parse_schemas/desk_booking/enum.dart';
import 'package:vizmo_models/utils/extension_utils.dart';

import '../../desk_booking/desk.dart';

class FloorLayout {
  FloorLayoutType? type;
  ParseFile? file;
  FloorLayout({
    this.file,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type == null ? null : describeEnum(type!),
      'file': file,
    };
  }

  factory FloorLayout.fromMap(Map<String, dynamic> map) {
    return FloorLayout(
      type: map['type'] == null
          ? null
          : stringToEnum(FloorLayoutType.values, map['type']),
      file: map['file'] != null ? map['file'] : null,
    );
  }

  @override
  bool operator ==(covariant FloorLayout other) {
    if (identical(this, other)) return true;

    return other.file?.url == file?.url;
  }

  @override
  int get hashCode => file.hashCode;
}

class ParseDeskPointer {
  final DeskSchema? pointer;
  final String? name;
  final String? floor;
  final String? zone;

  ParseDeskPointer({
    this.pointer,
    this.name,
    this.floor,
    this.zone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pointer': pointer,
      'name': name,
      'floor': floor,
      'zone': zone,
    };
  }

  factory ParseDeskPointer.fromMap(Map<String, dynamic> map) {
    return ParseDeskPointer(
      pointer: map['pointer'] == null
          ? null
          : map['pointer'] is ParseObject
              ? DeskSchema.fromObject(map['pointer'])
              : DeskSchema().fromJson(map['pointer']),
      name: map['name'] != null ? map['name'] as String : null,
      floor: map['floor'] != null ? map['floor'] as String : null,
      zone: map['zone'] != null ? map['zone'] as String : null,
    );
  }

  Desk toDesk({Desk? desk}) {
    return Desk(
      id: pointer?.objectId ?? desk?.id,
      cid: pointer?.company?.objectId ?? desk?.cid,
      lid: pointer?.location?.objectId ?? desk?.lid,
      name: pointer?.name ?? name ?? desk?.name,
      description: pointer?.description ?? desk?.description,
      enabled: pointer?.enabled ?? desk?.enabled ?? false,
      floor:
          pointer?.floor?.toFloor() ?? desk?.floor ?? Floor(name: this.floor),
      zone: pointer?.zone?.toZone() ?? desk?.zone ?? DeskZone(name: this.zone),
      position: pointer?.position ?? desk?.position,
    );
  }
}
