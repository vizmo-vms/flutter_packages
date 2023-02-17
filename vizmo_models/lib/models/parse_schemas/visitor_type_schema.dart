import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../checkin_field.dart';
import '../visitor_type.dart';
import 'company_schema.dart';
import 'location_schema.dart';

class VisitorTypeSchema extends ParseObject {
  VisitorTypeSchema() : super(_className);

  static VisitorTypeSchema fromObject(ParseObject object) {
    return VisitorTypeSchema().fromJson(object.toJson(full: true));
  }

  static const String _className = "VisitorType";

  static const String companyKey = "company";
  static const String locationKey = "location";
  static const String nameKey = "name";
  static const String displayNameKey = "displayName";
  static const String enabledKey = "enabled";
  static const String indexKey = "index";
  static const String hostScreenKey = "hostScreen";
  static const String checkinFieldsKey = "checkinFields";
  static const String badgeKey = "badge";
  static const String agreementKey = "agreement";
  static const String phoneScreenKey = "phoneScreen";
  static const String notificationsKey = "notifications";
  static const String idCardKey = "idCard";
  static const String photoKey = "photo";

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

  String? get name => get<String>(nameKey);
  String? get displayName => get<String>(displayNameKey);
  bool? get enabled => get<bool>(enabledKey);
  int? get index => get<int>(indexKey);
  HostScreen? get hostScreen => HostScreen.fromMap(
      get<Map<String, dynamic>>(hostScreenKey) ?? _defaultHostScreen);
  List<CheckinField>? get checkinFields =>
      (get<List>(checkinFieldsKey) ?? _defaultCheckinFields)
          .map((field) => CheckinField.fromMap(fieldMap: Map.from(field ?? {})))
          .toList();
  Badge get badge =>
      Badge.fromMap(get<Map<String, dynamic>>(badgeKey) ?? _defaultBadge);
  // TODO: add once support MD
  Agreement get agreement => Agreement.fromMap(
      get<Map<String, dynamic>>(agreementKey) ?? _defaultAgreement);
  PhoneScreen get phoneScreen => PhoneScreen.fromMap(
      get<Map<String, dynamic>>(phoneScreenKey) ?? _defaultPhoneScreen);
  Notifications get notifications => Notifications.fromMap(
      get<Map<String, dynamic>>(notificationsKey) ?? _defaultNotifications);
  IdCard get idCard =>
      IdCard.fromMap(get<Map<String, dynamic>>(idCardKey) ?? _defaultIdCard);
  Photo get photo =>
      Photo.fromMap(get<Map<String, dynamic>>(photoKey) ?? _defaultPhoto);

  VisitorType toVisitorType() {
    return VisitorType(
      id: this.objectId,
      cid: this.company?.objectId,
      lid: this.location?.objectId,
      name: this.name,
      displayName: this.displayName,
      enabled: this.enabled,
      index: this.index,
      hostScreen: this.hostScreen,
      checkinFields: this.checkinFields,
      badge: this.badge,
      agreement: this.agreement,
      phoneScreen: this.phoneScreen,
      notifications: this.notifications,
      idCard: this.idCard,
      photo: this.photo,
    );
  }

  // TODO: update defaults from server default schema
  final _defaultHostScreen = {
    "displayText": "Please select the person you want to meet",
    "fallbackHost": null,
    "hostSelection": true
  };

  final _defaultCheckinFields = [
    {
      "label": "First Name",
      "inputType": "text",
      "required": true,
      "id": "first_name",
      "type": "text_field",
      "hide": false
    },
    {
      "label": "Last Name",
      "inputType": "text",
      "required": false,
      "id": "last_name",
      "type": "text_field",
      "hide": false
    },
    {
      "label": "Email Address",
      "inputType": "email",
      "required": false,
      "id": "email",
      "type": "text_field",
      "hide": false
    },
    {
      "inputType": "text",
      "required": false,
      "id": "company",
      "type": "text_field",
      "label": "Company",
      "hide": false
    }
  ];

  final _defaultBadge = {"digitalBadge": false, "printBadge": false};

  final _defaultPhoneScreen = {"otpVerification": false};

  final _defaultNotifications = {"visitor": true, "host": true};

  final _defaultIdCard = {
    "returningVisitorId": false,
    "enabled": false,
    "validate": false
  };

  final _defaultPhoto = {"enabled": true, "returningVisitorPhoto": false};

  final _defaultAgreement = {
    "defaultContent":
        "<h2 style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(0, 0, 0); text-align: center;\"><span style=\"font-weight: 700;\"><span class=\"ql-cursor\"><br class=\"Apple-interchange-newline\">﻿﻿﻿</span>WELCOME TO OUR WORKPLACE&nbsp;</span></h2><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><h3 style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"><u>VISITOR GUIDELINES</u></span></h3><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">&nbsp;&nbsp;&nbsp;&nbsp;Visitors are welcome to visit during hours of operations. For your safety &amp; security we have the following guidelines.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(a)&nbsp;&nbsp;Agree to follow the Division’s rules before entry is permitted into the building.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(b)&nbsp;&nbsp;All visitors must sign in and out through the main entrance lobby.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(c)&nbsp;&nbsp;All visitors are required to read and acknowledge the Non-Disclosure and Waiver Agreement.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(d)&nbsp;&nbsp;Smoking/tobacco use is prohibited in our facility. Please use designated outside areas.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(e)&nbsp;&nbsp;Firearms/weapons are prohibited in our facility.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(f)&nbsp;&nbsp;In the event of an emergency. Follow signage to the designated muster point.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><h3 style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"><u>VISITOR’S NON-DISCLOSURE AND WAIVER AGREEMENT</u></span></h3><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">&nbsp;&nbsp;&nbsp;&nbsp;During my visit to your facility, I will learn and/or have disclosed to me proprietary or confidential information (including, without limitations, information relating to technology, trade secrets, processes, materials, equipment, drawings, specifications, prototypes and products) and may receive samples of products which not generally known to the public (hereinafter collectively called “Confidential Information”).</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">In consideration of your permission to visit your facility &amp; for the courtesies extended to me during my visit:<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">1.&nbsp;&nbsp;I agree that I will not, without your written permission or that of your authorized representative, either;<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(a)&nbsp;&nbsp;Disclose or otherwise make available to others any Confidential Information disclosed to me during this and any subsequent visit which (i) was not known to me or my organization prior to disclosure by you, or (ii) is not now or subsequently becomes a part of the public domain as a result of publication or otherwise; or<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(b)&nbsp;&nbsp;Use or assist others in using or further developing in any manner any confidential information.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(c)&nbsp;&nbsp;Use cameras or video technology to disclose confidential information.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">2.&nbsp;&nbsp;I also agree to conform to any applicable safety requirements, which are brought to my attention by any employee or by signs posted in the areas that I visit while on the premises, and to observe other reasonable safety precautions.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">3.&nbsp;&nbsp;I further agree to release the Division, its officers, agents, employees, invitees or licensees from all claims, losses, expenses (including attorney’s fees), interest, damage and liability to the extent caused by or resulting from my negligence or willful misconduct.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">4.&nbsp;&nbsp;Please be advised by signing into the facility, you have acknowledged and understand the Visitor Guidelines and Non-Disclosure Agreement posted.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><span style=\"font-weight: 700;\">THANK YOU</span></p>",
    "content":
        "<!DOCTYPE html><html style=\"zoom: 0.54\" lang=\"en\"><head><title></title><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"></head><body style=\"padding: 18px\"><h2 style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(0, 0, 0); text-align: center;\"><span style=\"font-weight: 700;\"><span class=\"ql-cursor\"><br class=\"Apple-interchange-newline\">﻿﻿﻿</span>WELCOME TO OUR WORKPLACE&nbsp;</span></h2><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><h3 style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"><u>VISITOR GUIDELINES</u></span></h3><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">&nbsp;&nbsp;&nbsp;&nbsp;Visitors are welcome to visit during hours of operations. For your safety &amp; security we have the following guidelines.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(a)&nbsp;&nbsp;Agree to follow the Division’s rules before entry is permitted into the building.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(b)&nbsp;&nbsp;All visitors must sign in and out through the main entrance lobby.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(c)&nbsp;&nbsp;All visitors are required to read and acknowledge the Non-Disclosure and Waiver Agreement.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(d)&nbsp;&nbsp;Smoking/tobacco use is prohibited in our facility. Please use designated outside areas.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(e)&nbsp;&nbsp;Firearms/weapons are prohibited in our facility.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(f)&nbsp;&nbsp;In the event of an emergency. Follow signage to the designated muster point.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><h3 style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"><u>VISITOR’S NON-DISCLOSURE AND WAIVER AGREEMENT</u></span></h3><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">&nbsp;&nbsp;&nbsp;&nbsp;During my visit to your facility, I will learn and/or have disclosed to me proprietary or confidential information (including, without limitations, information relating to technology, trade secrets, processes, materials, equipment, drawings, specifications, prototypes and products) and may receive samples of products which not generally known to the public (hereinafter collectively called “Confidential Information”).</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">In consideration of your permission to visit your facility &amp; for the courtesies extended to me during my visit:<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">1.&nbsp;&nbsp;I agree that I will not, without your written permission or that of your authorized representative, either;<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(a)&nbsp;&nbsp;Disclose or otherwise make available to others any Confidential Information disclosed to me during this and any subsequent visit which (i) was not known to me or my organization prior to disclosure by you, or (ii) is not now or subsequently becomes a part of the public domain as a result of publication or otherwise; or<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(b)&nbsp;&nbsp;Use or assist others in using or further developing in any manner any confidential information.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(c)&nbsp;&nbsp;Use cameras or video technology to disclose confidential information.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">2.&nbsp;&nbsp;I also agree to conform to any applicable safety requirements, which are brought to my attention by any employee or by signs posted in the areas that I visit while on the premises, and to observe other reasonable safety precautions.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">3.&nbsp;&nbsp;I further agree to release the Division, its officers, agents, employees, invitees or licensees from all claims, losses, expenses (including attorney’s fees), interest, damage and liability to the extent caused by or resulting from my negligence or willful misconduct.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">4.&nbsp;&nbsp;Please be advised by signing into the facility, you have acknowledged and understand the Visitor Guidelines and Non-Disclosure Agreement posted.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><span style=\"font-weight: 700;\">THANK YOU</span></p><br><br><div id=\"visitor-sign\" style=\"{{display}}\"><p style=\"text-align: center\"><img src=\"{{sign}}\" height=\"72\"></p><hr style=\"margin: 12px\"><p style=\"text-align: center;font-size: medium\">{{name}}</p><p style=\"text-align: center\">{{date}}</p></div></body></html>",
    "appendContent":
        "<!DOCTYPE html><html style=\"zoom: 0.54\" lang=\"en\"><head><title></title><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"></head><body style=\"padding: 18px\">{{editorContent}}<br><br><div id=\"visitor-sign\" style=\"{{display}}\"><p style=\"text-align: center\"><img src=\"{{sign}}\" height=\"72\"></p><hr style=\"margin: 12px\"><p style=\"text-align: center;font-size: medium\">{{name}}</p><p style=\"text-align: center\">{{date}}</p></div></body></html>",
    "editorContent":
        "<h2 style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(0, 0, 0); text-align: center;\"><span style=\"font-weight: 700;\"><span class=\"ql-cursor\"><br class=\"Apple-interchange-newline\">﻿﻿﻿</span>WELCOME TO OUR WORKPLACE&nbsp;</span></h2><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><h3 style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"><u>VISITOR GUIDELINES</u></span></h3><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">&nbsp;&nbsp;&nbsp;&nbsp;Visitors are welcome to visit during hours of operations. For your safety &amp; security we have the following guidelines.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(a)&nbsp;&nbsp;Agree to follow the Division’s rules before entry is permitted into the building.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(b)&nbsp;&nbsp;All visitors must sign in and out through the main entrance lobby.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(c)&nbsp;&nbsp;All visitors are required to read and acknowledge the Non-Disclosure and Waiver Agreement.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(d)&nbsp;&nbsp;Smoking/tobacco use is prohibited in our facility. Please use designated outside areas.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(e)&nbsp;&nbsp;Firearms/weapons are prohibited in our facility.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(f)&nbsp;&nbsp;In the event of an emergency. Follow signage to the designated muster point.</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><h3 style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"><u>VISITOR’S NON-DISCLOSURE AND WAIVER AGREEMENT</u></span></h3><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><p style=\"font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">&nbsp;&nbsp;&nbsp;&nbsp;During my visit to your facility, I will learn and/or have disclosed to me proprietary or confidential information (including, without limitations, information relating to technology, trade secrets, processes, materials, equipment, drawings, specifications, prototypes and products) and may receive samples of products which not generally known to the public (hereinafter collectively called “Confidential Information”).</p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">In consideration of your permission to visit your facility &amp; for the courtesies extended to me during my visit:<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">1.&nbsp;&nbsp;I agree that I will not, without your written permission or that of your authorized representative, either;<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(a)&nbsp;&nbsp;Disclose or otherwise make available to others any Confidential Information disclosed to me during this and any subsequent visit which (i) was not known to me or my organization prior to disclosure by you, or (ii) is not now or subsequently becomes a part of the public domain as a result of publication or otherwise; or<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(b)&nbsp;&nbsp;Use or assist others in using or further developing in any manner any confidential information.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">(c)&nbsp;&nbsp;Use cameras or video technology to disclose confidential information.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">2.&nbsp;&nbsp;I also agree to conform to any applicable safety requirements, which are brought to my attention by any employee or by signs posted in the areas that I visit while on the premises, and to observe other reasonable safety precautions.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">3.&nbsp;&nbsp;I further agree to release the Division, its officers, agents, employees, invitees or licensees from all claims, losses, expenses (including attorney’s fees), interest, damage and liability to the extent caused by or resulting from my negligence or willful misconduct.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\">4.&nbsp;&nbsp;Please be advised by signing into the facility, you have acknowledged and understand the Visitor Guidelines and Non-Disclosure Agreement posted.<br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><br></p><p style=\"margin-left: 25px; font-family: Roboto, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;\"><span style=\"font-weight: 700;\">THANK YOU</span></p>",
    "enabled": false,
  };
}
