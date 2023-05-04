import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:vizmo_models/models/location.dart';
import 'package:vizmo_models/models/parse_schemas/models.dart';
import 'package:vizmo_models/models/visitor.dart';
import 'package:vizmo_models/models/visitor_type.dart';
import 'package:vizmo_models/utils/validators.dart';

import 'checkin_field.dart';
import 'enum.dart';
import 'health_declaration.dart';
import 'host.dart';

class Attendee {
  String? id;

  String? _name;

  String? get name => _name ?? '$firstName $lastName';

  set name(String? name) {
    if (name?.isNotEmpty ?? false) _name = name;
  }

  String? firstName;
  String? lastName;

  ///
  /// email should be present for internal
  ///
  String? email;

  ///
  /// mobile number in E.164 format(removed country code)
  ///
  String? phone;

  ///
  /// Photo download url
  ///
  ///TODO:change in kiosk
  ParseFile? photo;

  ///
  /// saving the response.
  ///
  RSVP? rsvp;

  HealthDeclaration? healthDeclaration;

  String? companyName;

  ParseFile? idCard;

  IdCardType? idCardType;

  ParseAgreement? agreement;

  Map<String, CheckinField>? fields;

  bool? preFilled;

  InviteType? type;

  String? cid;

  String? lid;

  String? inviteId;

  //computed
  int? numberOfOccurrences;
  bool? usedToday;

  Attendee({
    this.id,
    this.firstName,
    this.lastName,
    this.healthDeclaration,
    this.email,
    this.phone,
    this.photo,
    this.rsvp,
    this.preFilled,
    this.numberOfOccurrences: 0,
    this.companyName,
    this.idCard,
    this.idCardType,
    this.agreement,
    this.fields,
    this.type,
    this.usedToday: false,
    this.cid,
    this.lid,
    this.inviteId,
  });

  bool get internal => type == InviteType.internal;

  factory Attendee.fromHost(Host val) {
    return Attendee(
      // name: val.name,
      firstName: val.firstName,
      lastName: val.lastName,
      email: val.email,
      phone: val.phone,
      cid: val.cid,
      lid: val.lid,
      type: InviteType.internal,
    );
  }

  factory Attendee.fromVisitor(Visitor val) {
    return Attendee(
      // name: val.name,s
      firstName: val.firstName,
      lastName: val.lastName,
      email: val.email,
      phone: val.phone,
      type: InviteType.external,
    );
  }

  factory Attendee.fromContact(Contact contact, {Location? location}) {
    final value = Attendee();

    value.phone =
        (contact.phones?.length ?? 0) > 0 ? contact.phones!.first.value : null;
    if (value.phone?.isNotEmpty ?? false) {
      value.phone = value.phone?.replaceAll(' ', '');
      if (value.phone?.startsWith('0') ?? false) {
        value.phone = value.phone
            ?.replaceFirst('0', '+${location?.country?.dialingCode ?? '91'}');
      }
      if (!(value.phone?.startsWith('+') ?? false)) {
        value.phone =
            '+${location?.country?.dialingCode ?? '91'}${value.phone}';
      }
    }
    value.email =
        (contact.emails?.length ?? 0) > 0 ? contact.emails!.first.value : null;

    value.firstName = contact.givenName;
    value.lastName = contact.familyName;
    if ((value.firstName?.isEmpty ?? true) ||
        (value.lastName?.isEmpty ?? true)) {
      final displayName = contact.displayName?.trim();
      if (displayName?.contains(" ") ?? false) {
        value.firstName = displayName?.split(" ")[0];
        value.lastName = displayName?.split(" ")[1];
      }
      // else {
      //   value.firstName = displayName;
      //   value.lastName = displayName;
      // }
    }

    value.companyName = contact.company;

    value.type = InviteType.external;
    return value;
  }

  Future<bool> isValid() async {
    if (this.firstName?.isEmpty ?? true) return false;
    if (this.lastName?.isEmpty ?? true) return false;
    if (this.name?.isEmpty ?? true) return false;
    if ((this.phone?.isEmpty ?? true) && (this.email?.isEmpty ?? true))
      return false;

    if (this.phone?.isNotEmpty ?? false) {
      final _validPhone = await Validators.validatePhone(this.phone!);

      if (_validPhone != null) return false;
    }
    if (this.email?.isNotEmpty ?? false) {
      final _validEmail = Validators.isValidEmail(this.email!);
      if (!_validEmail) return false;
    }

    return true;
  }
}
