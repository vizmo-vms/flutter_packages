import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:vizmo_models/models/settings.dart';
import 'company_schema.dart';
import 'location_schema.dart';

class SettingsSchema extends ParseObject {
  SettingsSchema() : super(_className);

  static SettingsSchema fromObject(ParseObject object) {
    return SettingsSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "Settings";
  static const String companyKey = "company";
  static const String locationKey = "location";
  static const String brandingKey = "branding";
  static const String checkinKey = "checkin";
  static const String checkoutKey = "checkout";
  static const String inviteKey = "invite";
  static const String notificationsKey = "notifications";
  static const String acceptRejectKey = "acceptReject";
  static const String healthDeclarationKey = "healthDeclaration";
  static const String deskKey = "desk";

  CompanySchema? get company {
    var result = get(companyKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return CompanySchema()..fromJson(result.toJson(full: true));
    }
    return CompanySchema()..fromJson(result);
  }

  LocationSchema? get location {
    var result = get(locationKey);
    if (result == null) return null;

    if (result is ParseObject) {
      return LocationSchema()..fromJson(result.toJson(full: true));
    }
    return LocationSchema()..fromJson(result);
  }

  BrandingSettings get branding =>
      BrandingSettings.fromMap((get<Map<String, dynamic>>(brandingKey) ?? {})
        ..update(
          'logo',
          (value) {
            if (value is ParseFile) {
              final _url = value.url;

              return _url;
            }
            return value;
          },
          ifAbsent: () => null,
        ));
  CheckinSettings get checkin =>
      CheckinSettings.fromMap(get<Map<String, dynamic>>(checkinKey) ?? {});
  CheckoutSettings get checkout =>
      CheckoutSettings.fromMap(get<Map<String, dynamic>>(checkoutKey) ?? {});
  InviteSettings get invite =>
      InviteSettings.fromMap(get<Map<String, dynamic>>(inviteKey) ?? {});
  NotificationsSettings get notifications => NotificationsSettings.fromMap(
      get<Map<String, dynamic>>(notificationsKey) ?? {});
  AcceptRejectSettings get acceptReject => AcceptRejectSettings.fromMap(
      get<Map<String, dynamic>>(acceptRejectKey) ?? {});
  HealthDeclarationSettings get healthDeclaration =>
      HealthDeclarationSettings.fromMap(
          get<Map<String, dynamic>>(healthDeclarationKey) ?? {});
  DeskSettings get desk =>
      DeskSettings.fromMap(get<Map<String, dynamic>>(deskKey) ?? {});

  Settings toSettings() {
    return new Settings(
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      acceptRejectSettings: this.acceptReject,
      branding: this.branding,
      checkin: this.checkin,
      checkout: this.checkout,
      healthDeclarationSettings: this.healthDeclaration,
      inviteSettings: this.invite,
      notifications: this.notifications,
      deskSettings: this.desk,
    );
  }
}
