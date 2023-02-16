class CapacitySettings {
  bool? enabled;
  Map<String, CapacitySettingsVisitorType>? visitorTypes;
  int? overallCount;
  CapacitySettingsNotification? notifications;

  CapacitySettings({
    this.enabled,
    this.visitorTypes,
    this.overallCount,
    this.notifications,
  });

  factory CapacitySettings.fromMap(Map<String, dynamic> map) {
    return CapacitySettings(
      enabled: map['enabled'],
      visitorTypes: map['visitorTypes'] is List
          ? List.from(map['visitorTypes'] ?? []).asMap().map((key, value) =>
              MapEntry(
                  value,
                  CapacitySettingsVisitorType.fromMap(
                      value, {'enabled': true})))
          : Map.from(map['visitorTypes'] ?? {}).map((key, value) => MapEntry(
              key,
              CapacitySettingsVisitorType.fromMap(key, Map.from(value ?? {})))),
      overallCount: map['overallCount'],
      notifications:
          CapacitySettingsNotification.fromMap(map['notifications'] ?? {}),
    );
  }
}

class CapacitySettingsVisitorType {
  String? visitorTypeKey;
  bool? enabled;
  int? count;
  CapacitySettingsVisitorType({
    this.visitorTypeKey,
    this.enabled,
    this.count,
  });

  factory CapacitySettingsVisitorType.fromMap(
      String key, Map<String, dynamic> map) {
    return CapacitySettingsVisitorType(
      visitorTypeKey: key,
      enabled: map['enabled'],
      count: map['count'],
    );
  }
}

class CapacitySettingsNotification {
  bool? enabled;
  CapacitySettingsNotification({
    this.enabled,
    this.assignedTo,
  });
  CapacitySettingsNotificationAssignedTo? assignedTo;

  factory CapacitySettingsNotification.fromMap(Map<String, dynamic> map) {
    return CapacitySettingsNotification(
      enabled: map['enabled'],
      assignedTo:
          CapacitySettingsNotificationAssignedTo.fromMap(map['assignedTo']),
    );
  }
}

class CapacitySettingsNotificationAssignedTo {
  String? name;
  String? uid;
  CapacitySettingsNotificationAssignedTo({
    this.name,
    this.uid,
  });

  factory CapacitySettingsNotificationAssignedTo.fromMap(dynamic map) {
    if (map == null) CapacitySettingsNotificationAssignedTo();

    if (map is String) {
      return CapacitySettingsNotificationAssignedTo(
        uid: map,
      );
    }
    return CapacitySettingsNotificationAssignedTo(
      name: map['name'],
      uid: map['uid'],
    );
  }
}

class Capacity {
  Map<String, int>? visitorTypes;
  Capacity({
    this.visitorTypes,
  });

  factory Capacity.fromMap(Map<String, dynamic>? map) {
    if (map?.isEmpty ?? true) map = {};

    return Capacity(
      visitorTypes: Map.from(map!['visitorTypes'] ?? {}),
    );
  }

  int get overallCount => (visitorTypes?.isEmpty ?? true)
      ? 0
      : visitorTypes?.values.reduce((val, elm) => val + (elm)) ?? 0;
}
