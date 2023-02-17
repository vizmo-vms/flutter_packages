// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:vizmo_models/utils/utils.dart';
import 'package:vizmo_models/models/approval.dart';
import 'package:vizmo_models/models/capacity_settings.dart';

class Settings {
  Settings({
    this.cid,
    this.lid,
    this.branding,
    this.checkin,
    this.checkout,
    this.inviteSettings,
    this.acceptRejectSettings,
    // this.appSettings,
    this.healthDeclarationSettings,
    this.notifications,
    this.createdAt,
    this.updatedAt,
    this.objectId,
    this.employeePassSettings,
    this.deskSettings,
  });

  String? cid;
  String? lid;
  BrandingSettings? branding;
  // AppSettings appSettings;
  CheckinSettings? checkin;
  CheckoutSettings? checkout;
  InviteSettings? inviteSettings;
  AcceptRejectSettings? acceptRejectSettings;
  HealthDeclarationSettings? healthDeclarationSettings;
  NotificationsSettings? notifications;
  CapacitySettings? capacitySettings;
  EmployeePassSettings? employeePassSettings;
  DeskSettings? deskSettings;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? objectId;

  Settings.fromMap(Map<String, dynamic> map)
      : branding = BrandingSettings.fromMap(
            Map<String, dynamic>.from(map['account'] ?? map['branding'] ?? {})),
        inviteSettings = InviteSettings.fromMap(
            Map<String, dynamic>.from(map['invites'] ?? {})),
        acceptRejectSettings = AcceptRejectSettings.fromMap(
          Map<String, dynamic>.from(map['acceptReject'] ?? {}),
        ),
        healthDeclarationSettings = HealthDeclarationSettings.fromMap(
          Map<String, dynamic>.from(map['healthDeclaration'] ?? {}),
        ),
        checkin = CheckinSettings.fromMap(
            Map<String, dynamic>.from(map['checkin'] ?? {})),
        capacitySettings =
            CapacitySettings.fromMap(Map.from(map['capacity'] ?? {})),
        employeePassSettings =
            EmployeePassSettings.fromMap(Map.from(map['employeePass'] ?? {}));

  void decodeSettingsMap(Map<String, dynamic> map) {
    this.branding = BrandingSettings.fromMap(
        Map<String, dynamic>.from(map['account'] ?? map['branding'] ?? {}));
    this.inviteSettings =
        InviteSettings.fromMap(Map<String, dynamic>.from(map['invites'] ?? {}));
    this.acceptRejectSettings = AcceptRejectSettings.fromMap(
      Map<String, dynamic>.from(map['acceptReject'] ?? {}),
    );
    this.healthDeclarationSettings = HealthDeclarationSettings.fromMap(
      Map<String, dynamic>.from(map['healthDeclaration'] ?? {}),
    );
    this.checkin = CheckinSettings.fromMap(
        Map<String, dynamic>.from(map['checkin'] ?? {}));
    this.capacitySettings =
        CapacitySettings.fromMap(Map.from(map['capacity'] ?? {}));
    this.employeePassSettings =
        EmployeePassSettings.fromMap(Map.from(map['employeePass'] ?? {}));

    if (map['appSettings'] != null) {
      final _app = AppSettings.fromMap(
          Map<String, dynamic>.from(map['appSettings'] ?? {}));

      this.checkin = CheckinSettings(
        inviteOnly: _app.inviteOnly ?? false,
        returningVisitors: _app.returningVisitors ?? false,
        staticToken: this.checkin?.staticToken,
      );

      this.checkout = CheckoutSettings(
        autoCheckout: this.checkout?.autoCheckout,
        overstay: this.checkout?.overstay,
        selfCheckout: _app.selfCheckOut,
      );
    }
  }
}

class EmployeePassSettings {
  bool? enabled;

  ///list of visitor-type keys
  List<String>? list;
  EmployeePassSettings({
    this.enabled,
    this.list,
  });

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'list': list,
    };
  }

  factory EmployeePassSettings.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return EmployeePassSettings(
        enabled: false,
        list: [],
      );
    }
    return EmployeePassSettings(
      enabled: map['enabled'] ?? false,
      list: List<String>.from(map['list'] ?? []),
    );
  }
}

@deprecated
class AppSettings {
  bool? returningVisitors;
  bool? selfCheckOut;
  bool? inviteOnly;

  AppSettings.fromMap(Map<String, dynamic> map)
      : returningVisitors = map['returningVisitors'],
        selfCheckOut = map['selfCheckout'],
        inviteOnly = map['inviteOnly'] ?? false;
}

class AcceptRejectSettings {
  AcceptRejectSettings({
    this.enabled,
    this.timeout,
  });

  final bool? enabled;
  final int? timeout;

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'timeout': timeout,
    };
  }

  factory AcceptRejectSettings.fromMap(Map<String, dynamic> map) {
    return AcceptRejectSettings(
      enabled: map['enabled'],
      timeout: map['timeout'] is String
          ? int.tryParse(map['timeout'] ?? '') ?? 0
          : map['timeout'],
    );
  }
}

class BrandingSettings {
  BrandingSettings({
    this.logo,
    this.themeColor,
  });
// TODO: make this as parse file
  final String? logo;
  final Color? themeColor;

  factory BrandingSettings.fromMap(Map<String, dynamic> map) {
    return BrandingSettings(
      logo: map['logo'],
      themeColor: Color(int.parse("0xFF" + (map['themeColor'] ?? "0094A1"))),
    );
  }
}

class CheckinSettings {
  CheckinSettings({
    this.returningVisitors,
    this.inviteOnly,
    this.staticToken,
  });

  final bool? returningVisitors;
  final bool? inviteOnly;
  final StaticToken? staticToken;

  Map<String, dynamic> toMap() {
    return {
      'returningVisitors': returningVisitors,
      'inviteOnly': inviteOnly,
      'staticToken': staticToken?.toMap(),
    };
  }

  factory CheckinSettings.fromMap(Map<String, dynamic> map) {
    return CheckinSettings(
      returningVisitors: map['returningVisitors'],
      inviteOnly: map['inviteOnly'],
      staticToken: StaticToken.fromMap(Map.from(map['staticToken'] ?? {})),
    );
  }
}

class StaticToken {
  StaticToken({
    this.enabled,
    this.token,
    this.validity,
    this.expiresAt,
  });

  final bool? enabled;
  final String? token;
  final int? validity;
  final DateTime? expiresAt;

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'token': token,
      'validity': validity,
      'expiresAt': expiresAt,
    };
  }

  factory StaticToken.fromMap(Map<String, dynamic> map) {
    return StaticToken(
      enabled: map['enabled'],
      token: map['token'],
      validity: map['validity'],
      expiresAt: Utils.getDateTime(map['expiresAt']),
    );
  }
}

class CheckoutSettings {
  CheckoutSettings({
    this.selfCheckout,
    this.autoCheckout,
    this.overstay,
  });

  final bool? selfCheckout;
  final bool? autoCheckout;
  final Overstay? overstay;

  Map<String, dynamic> toMap() {
    return {
      'selfCheckout': selfCheckout,
      'autoCheckout': autoCheckout,
      'overstay': overstay?.toMap(),
    };
  }

  factory CheckoutSettings.fromMap(Map<String, dynamic> map) {
    return CheckoutSettings(
      selfCheckout: map['selfCheckout'],
      autoCheckout: map['autoCheckout'],
      overstay: Overstay.fromMap(Map.from(map['overstay'] ?? {})),
    );
  }
}

class Overstay {
  Overstay({
    this.enabled,
    this.allowedStayDuration,
  });

  final bool? enabled;
  final int? allowedStayDuration;

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'allowedStayDuration': allowedStayDuration,
    };
  }

  factory Overstay.fromMap(Map<String, dynamic> map) {
    return Overstay(
      enabled: map['enabled'],
      allowedStayDuration: map['allowedStayDuration'],
    );
  }
}

class HealthDeclarationSettings {
  HealthDeclarationSettings({
    this.title,
    this.enabled,
    this.fields,
    this.approval,
    this.redeclaration,
  });

  final String? title;
  final bool? enabled;
  final List<Field?>? fields;
  final Approval? approval;
  final Redeclaration? redeclaration;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'enabled': enabled,
      'fields': fields?.map((x) => x?.toMap()).toList(),
      'approval': approval?.toMap(),
      'redeclaration': redeclaration?.toMap(),
    };
  }

  factory HealthDeclarationSettings.fromMap(Map<String, dynamic> map) {
    return HealthDeclarationSettings(
      title: map['title'],
      enabled: map['enabled'] ?? false,
      fields:
          List<Field>.from(map['fields']?.map((x) => Field.fromMap(x)) ?? []),
      approval: Approval.fromMap(Map.from(map['approval'] ?? {})),
      redeclaration:
          Redeclaration.fromMap(Map.from(map['redeclaration'] ?? {})),
    );
  }
}

class Field {
  Field({
    this.required,
    this.id,
    this.title,
    this.value,
  });

  final bool? required;
  final String? id;
  final String? title;
  final dynamic value;

  Map<String, dynamic> toMap() {
    return {
      'required': required,
      'id': id,
      'title': title,
      'value': value,
    };
  }

  factory Field.fromMap(Map<String, dynamic> map) {
    return Field(
      required: map['required'],
      id: map['id'],
      title: map['title'],
      value: map['value'],
    );
  }
}

class Redeclaration {
  Redeclaration({
    this.enabled,
    this.interval,
  });

  final bool? enabled;
  final int? interval;

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'interval': interval,
    };
  }

  factory Redeclaration.fromMap(Map<String, dynamic> map) {
    return Redeclaration(
      enabled: map['enabled'],
      interval: map['interval'],
    );
  }
}

class InviteSettings {
  InviteApprovalSetting approval;
  InviteNotificationsSetting notifications;
  bool shouldFillRequiredFields = false;
  bool shouldSignAgreement = false;
  bool shouldCaptureId = false;
  bool shouldTakePhoto = false;
  bool shouldExpire = true;
  bool enabled = false;

  InviteSettings.fromMap(Map<String, dynamic> map)
      : enabled = map['enabled'] ?? false,
        shouldFillRequiredFields = map['shouldFillRequiredFields'] ?? false,
        shouldSignAgreement = map['shouldSignAgreement'] ?? false,
        shouldCaptureId = map['shouldCaptureId'] ?? false,
        shouldTakePhoto = map['shouldTakePhoto'] ?? false,
        shouldExpire = map['shouldExpire'] ?? true,
        notifications = InviteNotificationsSetting.fromMap(
            Map.from(map['notifications'] ?? {})),
        approval =
            InviteApprovalSetting.fromMap(Map.from(map['approval'] ?? {}));
}

class InviteApprovalSetting {
  Approver? approver;
  _EnabledFor enabledFor;
  InviteApprovalSetting({
    required this.approver,
    required this.enabledFor,
  });

  factory InviteApprovalSetting.fromMap(Map<String, dynamic> map) {
    return InviteApprovalSetting(
      approver:
          map['approver'] == null ? null : Approver.parse(map['approver']),
      enabledFor: _EnabledFor.fromMap(Map.from(map['enabledFor'] ?? {})),
    );
  }
}

class _EnabledFor {
  bool? recurring;
  bool? nonRecurring;
  _EnabledFor({
    this.recurring,
    this.nonRecurring,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recurring': recurring,
      'nonRecurring': nonRecurring,
    };
  }

  factory _EnabledFor.fromMap(Map<String, dynamic> map) {
    return _EnabledFor(
      recurring: map['recurring'] != null ? map['recurring'] as bool : false,
      nonRecurring:
          map['nonRecurring'] != null ? map['nonRecurring'] as bool : false,
    );
  }
}

class InviteNotificationsSetting {
  final bool? sms;
  final bool? email;

  InviteNotificationsSetting(this.sms, this.email);

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'sms': sms,
  //     'email': email,
  //   };
  // }

  factory InviteNotificationsSetting.fromMap(Map<String, dynamic> map) {
    return InviteNotificationsSetting(
      map['sms'] != null ? map['sms'] as bool : false,
      map['email'] != null ? map['email'] as bool : false,
    );
  }
}

class NotificationsSettings {
  NotificationsSettings({
    this.enabled,
    this.sms,
    this.email,
    this.push,
  });

  final bool? enabled;
  final bool? sms;
  final bool? email;
  final bool? push;

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'sms': sms,
      'email': email,
      'push': push,
    };
  }

  factory NotificationsSettings.fromMap(Map<String, dynamic> map) {
    return NotificationsSettings(
      enabled: map['enabled'],
      sms: map['sms'],
      email: map['email'],
      push: map['push'],
    );
  }
}

class DeskSettings {
  final bool enabled;
  DeskSettings({
    this.enabled: false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enabled': enabled,
    };
  }

  factory DeskSettings.fromMap(Map<String, dynamic> map) {
    return DeskSettings(
      enabled: (map['enabled'] ?? false) as bool,
    );
  }
}
