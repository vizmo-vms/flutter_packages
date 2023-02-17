import 'package:vizmo_models/models/host.dart';
import 'package:vizmo_models/models/settings.dart';

import 'checkin_field.dart';

class VisitorType {
  VisitorType({
    this.id,
    this.cid,
    this.lid,
    this.name,
    this.displayName,
    this.enabled,
    this.index,
    this.hostScreen,
    this.checkinFields,
    this.badge,
    this.agreement,
    this.phoneScreen,
    this.notifications,
    this.idCard,
    this.photo,
    this.settingsOverrides,
  });

  final String? id;
  final String? cid;
  final String? lid;
  final String? name;
  final String? displayName;
  final bool? enabled;
  final int? index;
  final HostScreen? hostScreen;
  final List<CheckinField>? checkinFields;
  final Badge? badge;
  final Agreement? agreement;
  final PhoneScreen? phoneScreen;
  final Notifications? notifications;
  final IdCard? idCard;
  final Photo? photo;
  final SettingsOverrides? settingsOverrides;

  factory VisitorType.fromMap(String? key, Map<String, dynamic> map) {
    return VisitorType(
      id: key ?? map['name'],
      name: map['name'],
      displayName: map['displayName'],
      enabled: map['enabled'],
      index: map['index'],
      hostScreen: HostScreen.fromMap(Map.from(map['hostScreen'] ?? {})),
      checkinFields: List<CheckinField>.from(
          List.from(map['checkinFields'] ?? [])
              .map((x) => CheckinField.fromMap(fieldMap: x))),
      badge: Badge.fromMap(Map.from(map['badge'] ?? {})),
      agreement: Agreement.fromMap(Map.from(map['agreement'] ?? {})),
      phoneScreen: PhoneScreen.fromMap(Map.from(map['phoneScreen'] ?? {})),
      notifications:
          Notifications.fromMap(Map.from(map['notifications'] ?? {})),
      idCard: IdCard.fromMap(Map.from(map['idCard'] ?? {})),
      photo: Photo.fromMap(Map.from(map['photo'] ?? {})),
      settingsOverrides:
          SettingsOverrides.fromMap(Map.from(map['settingsOverrides'] ?? {})),
    );
  }

  factory VisitorType.firebaseFromMap(
      {String? key, Map<String, dynamic>? map}) {
    if (map == null) map = {};
    final _general =
        General.fromMap(Map<String, dynamic>.from(map['general'] ?? {}));

    return VisitorType(
      id: map['name'] ?? key,
      name: map['name'] ?? key,
      //TODO:Needs to be reviewed
      // lid: lid,
      displayName: _general.typeName,
      enabled: _general.enabled,
      index: _general.index,
      hostScreen: HostScreen.fromMap(Map.from(map['hostScreen'] ?? {})),
      checkinFields: List<CheckinField>.from(
          List.from(map['checkinFields'] ?? [])
              .map((x) => CheckinField.fromMap(fieldMap: x))),
      badge: Badge.fromMap(Map.from(map['badge'] ?? {})),
      agreement: Agreement.fromMap(Map.from(map['agreement'] ?? {})),
      phoneScreen: PhoneScreen.fromMap(Map.from(map['phoneScreen'] ?? {})),
      notifications:
          Notifications.fromMap(Map.from(map['notifications'] ?? {})),
      idCard: IdCard.fromMap(Map.from(map['idCard'] ?? {})),
      photo: Photo.fromMap(Map.from(map['photo'] ?? {})),
      settingsOverrides:
          SettingsOverrides.fromMap(Map.from(map['settingsOverrides'] ?? {})),
    );
  }
}

@deprecated

///Use only for firebase settings
class General {
  int? index;
  String? typeName;
  bool? enabled;

  General({this.index, this.typeName, this.enabled});

  General.fromMap(Map<String, dynamic> generalMap)
      : index = generalMap['index'],
        typeName = generalMap['typeName'],
        enabled = generalMap['enabled'];
}

class Agreement {
  Agreement({
    this.defaultContent,
    this.enabled,
    this.content,
    this.appendContent,
    this.editorContent,
  });

  final String? defaultContent;
  final bool? enabled;
  final String? content;
  final String? appendContent;
  final String? editorContent;

  // Map<String, dynamic> toMap() {
  //   return {
  //     'defaultContent': defaultContent,
  //     'enabled': enabled,
  //     'content': content,
  //     'appendContent': appendContent,
  //     'editorContent': editorContent,
  //   };
  // }

  factory Agreement.fromMap(Map<String, dynamic> map) {
    return Agreement(
      defaultContent: map['defaultContent'],
      enabled: map['enabled'] ?? map['visitorAgreement'] ?? false,
      content: map['content'] ?? map['defaultContent'],
      appendContent: map['appendContent'],
      editorContent: map['editorContent'],
    );
  }
}

class Badge {
  Badge({
    this.digitalBadge,
    this.printBadge,
  });

  final bool? digitalBadge;
  final bool? printBadge;

  Map<String, dynamic> toMap() {
    return {
      'digitalBadge': digitalBadge,
      'printBadge': printBadge,
    };
  }

  factory Badge.fromMap(Map<String, dynamic> map) {
    return Badge(
      digitalBadge: map['digitalBadge'] ?? false,
      printBadge: map['printBadge'] ?? false,
    );
  }
}

class HostScreen {
  HostScreen({
    this.displayText,
    this.fallbackHost,
    this.hostSelection,
  });

  final String? displayText;
  final Host? fallbackHost;
  final bool? hostSelection;

  factory HostScreen.fromMap(Map<String, dynamic> map) {
    return HostScreen(
      displayText: map['displayText'],
      fallbackHost:
          map['fallbackHost'] != null ? Host.parse(map['fallbackHost']) : null,
      hostSelection: map['hostSelection'] ?? true,
    );
  }
}

class IdCard {
  IdCard({
    this.returningVisitorId,
    this.enabled,
    this.validate,
    this.types: const [],
  });

  final bool? returningVisitorId;
  final bool? enabled;
  final bool? validate;
  final List<IdCardType> types;

  // Map<String, dynamic> toMap() {
  //   return {
  //     'returningVisitorId': returningVisitorId,
  //     'enabled': enabled,
  //     'validate': validate,
  //   };
  // }

  factory IdCard.fromMap(Map<String, dynamic> map) {
    return IdCard(
      returningVisitorId: map['returningVisitorId'] ?? false,
      enabled: map['enabled'] ?? map['visitorId'] ?? false,
      validate: map['validate'] ?? false,
      types: List.from(map['types'] ?? [])
          .map((x) => IdCardType.fromMap(Map.from(x ?? {})))
          .toList(),
    );
  }
}

class IdCardType {
  String? id;
  String? name;
  IdCardType({
    required this.id,
    required this.name,
  });

  factory IdCardType.fromMap(Map<String, dynamic> map) {
    return IdCardType(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  bool operator ==(covariant IdCardType other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Notifications {
  Notifications({
    this.visitor,
    this.host,
  });

  final bool? visitor;
  final bool? host;

  Map<String, dynamic> toMap() {
    return {
      'visitor': visitor,
      'host': host,
    };
  }

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      visitor: map['visitor'],
      host: map['host'],
    );
  }
}

class PhoneScreen {
  PhoneScreen({
    this.otpVerification,
  });

  final bool? otpVerification;

  Map<String, dynamic> toMap() {
    return {
      'otpVerification': otpVerification,
    };
  }

  factory PhoneScreen.fromMap(Map<String, dynamic> map) {
    return PhoneScreen(
      otpVerification: map['otpVerification'] ?? false,
    );
  }
}

class Photo {
  Photo({
    this.enabled,
    this.returningVisitorPhoto,
    this.facialDetection,
  });

  final bool? enabled;
  final bool? returningVisitorPhoto;
  final bool? facialDetection;

  // Map<String, dynamic> toMap() {
  //   return {
  //     'enabled': enabled,
  //     'returningVisitorPhoto': returningVisitorPhoto,
  //     'facialDetection': facialDetection,
  //   };
  // }

  factory Photo.fromMap(Map<String, dynamic> map) {
    return Photo(
      enabled: map['enabled'] ?? map['visitorPhoto'] ?? true,
      returningVisitorPhoto: map['returningVisitorPhoto'] ?? false,
      facialDetection: map['facialDetection'] ?? false,
    );
  }
}

class SettingsOverrides {
  AcceptRejectSettings? acceptReject;
  CheckinSettings? checkin;
  CheckoutSettings? checkout;
  HealthDeclarationSettings? healthDeclaration;

  SettingsOverrides({
    this.acceptReject,
    this.checkin,
    this.checkout,
    this.healthDeclaration,
  });

  factory SettingsOverrides.fromMap(Map<String, dynamic> map) {
    return SettingsOverrides(
      acceptReject: map['acceptReject'] != null
          ? AcceptRejectSettings.fromMap(
              map['acceptReject'] as Map<String, dynamic>)
          : null,
      checkin: map['checkin'] != null
          ? CheckinSettings.fromMap(map['checkin'] as Map<String, dynamic>)
          : null,
      checkout: map['checkout'] != null
          ? CheckoutSettings.fromMap(map['checkout'] as Map<String, dynamic>)
          : null,
      healthDeclaration: map['healthDeclaration'] != null
          ? HealthDeclarationSettings.fromMap(
              map['healthDeclaration'] as Map<String, dynamic>)
          : null,
    );
  }
}
