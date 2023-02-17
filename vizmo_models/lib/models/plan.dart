import 'enum.dart';

class Plan {
  _Flags? flags;
  _Limits? limits;
  String? cid;
  String? lid;
  PlanCode? planCode;

  Plan.fromJson(Map<String, dynamic> json) {
    flags = json['flags'] != null ? new _Flags.fromJson(json['flags']) : null;
    limits =
        json['limits'] != null ? new _Limits.fromJson(json['limits']) : null;
  }
}

class _Flags {
  bool? role;
  bool? printer;
  _VisitorLog? visitorLog;
  bool? invite;
  _Employee? employee;
  _VisitorType? visitorType;
  _Settings? settings;
  _IntegrationInstance? integrationInstance;

  _Flags.fromJson(Map<String, dynamic> json) {
    role = json['Role'];
    printer = json['Printer'];
    visitorLog = json['VisitorLog'] != null
        ? new _VisitorLog.fromJson(json['VisitorLog'])
        : null;
    invite = json['Approval'];
    employee = json['Employee'] != null
        ? new _Employee.fromJson(json['Employee'])
        : null;
    visitorType = json['VisitorType'] != null
        ? new _VisitorType.fromJson(json['VisitorType'])
        : null;
    settings = json['Settings'] != null
        ? new _Settings.fromJson(json['Settings'])
        : null;
    integrationInstance = json['IntegrationInstance'] != null
        ? new _IntegrationInstance.fromJson(json['IntegrationInstance'])
        : null;
  }
}

class _VisitorLog {
  _Source? source;

  _VisitorLog.fromJson(Map<String, dynamic> json) {
    source =
        json['source'] != null ? new _Source.fromJson(json['source']) : null;
  }
}

class _Source {
  bool? portal;

  _Source.fromJson(Map<String, dynamic> json) {
    portal = json['portal'];
  }
}

class _Employee {
  bool? assistant;

  _Employee.fromJson(Map<String, dynamic> json) {
    assistant = json['assistant'];
  }
}

class _VisitorType {
  bool? otpVerification;
  bool? hostSelection;
  bool? checkinFields;
  bool? agreement;
  _Photo? photo;
  _IdCard? idCard;
  _Badge? badge;
  _VisitorTypeNotifications? notifications;

  _VisitorType.fromJson(Map<String, dynamic> json) {
    otpVerification = json['otpVerification'];
    hostSelection = json['hostSelection'];
    checkinFields = json['checkinFields'];
    agreement = json['agreement'];
    photo = json['photo'] != null ? new _Photo.fromJson(json['photo']) : null;
    idCard =
        json['idCard'] != null ? new _IdCard.fromJson(json['idCard']) : null;
    badge = json['badge'] != null ? new _Badge.fromJson(json['badge']) : null;
    notifications = json['notifications'] != null
        ? new _VisitorTypeNotifications.fromJson(json['notifications'])
        : null;
  }
}

class _Photo {
  bool? enabled;
  bool? returningVisitorPhoto;

  _Photo.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    returningVisitorPhoto = json['returningVisitorPhoto'];
  }
}

class _IdCard {
  bool? enabled;
  bool? returningVisitorIdCard;

  _IdCard.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    returningVisitorIdCard = json['returningVisitorIdCard'];
  }
}

class _Badge {
  bool? print;
  bool? digital;

  _Badge.fromJson(Map<String, dynamic> json) {
    print = json['print'];
    digital = json['digital'];
  }
}

class _VisitorTypeNotifications {
  bool? visitor;
  bool? host;
  bool? forward;

  _VisitorTypeNotifications.fromJson(Map<String, dynamic> json) {
    visitor = json['visitor'];
    host = json['host'];
    forward = json['forward'];
  }
}

class _Settings {
  _Checkin? checkin;
  _Checkout? checkout;
  bool? acceptReject;
  _Approval? invite;
  _Approval? healthDeclaration;
  _Desk? desk;
  _Notifications? notifications;

  _Settings.fromJson(Map<String, dynamic> json) {
    checkin =
        json['checkin'] != null ? new _Checkin.fromJson(json['checkin']) : null;
    checkout = json['checkout'] != null
        ? new _Checkout.fromJson(json['checkout'])
        : null;
    acceptReject = json['acceptReject'];
    invite =
        json['invite'] != null ? new _Approval.fromJson(json['invite']) : null;
    healthDeclaration = json['healthDeclaration'] != null
        ? new _Approval.fromJson(json['healthDeclaration'])
        : null;
    desk = json['desk'] != null ? new _Desk.fromJson(json['desk']) : null;
    notifications = json['notifications'] != null
        ? new _Notifications.fromJson(json['notifications'])
        : null;
  }
}

class _Checkin {
  bool? returningVisitors;
  bool? staticToken;

  _Checkin.fromJson(Map<String, dynamic> json) {
    returningVisitors = json['returningVisitors'];
    staticToken = json['staticToken'];
  }
}

class _Checkout {
  bool? autoCheckout;
  bool? overstay;

  _Checkout.fromJson(Map<String, dynamic> json) {
    autoCheckout = json['autoCheckout'];
    overstay = json['overstay'];
  }
}

class _Approval {
  bool? enabled;
  bool? approval;

  _Approval.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    approval = json['approval'];
  }
}

class _Desk {
  bool? enabled;

  _Desk.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
  }
}

class _Notifications {
  bool? sms;
  bool? email;
  bool? push;

  _Notifications.fromJson(Map<String, dynamic> json) {
    sms = json['sms'];
    email = json['email'];
    push = json['push'];
  }
}

class _IntegrationInstance {
  bool? googleWorkspaceDirectory;
  bool? azureAd;
  bool? scim;
  bool? saml;
  bool? restApiV1;
  bool? slack;

  _IntegrationInstance.fromJson(Map<String, dynamic> json) {
    googleWorkspaceDirectory = json['google-workspace-directory'];
    azureAd = json['azure-ad'];
    scim = json['scim'];
    saml = json['saml'];
    restApiV1 = json['rest-api-v1'];
    slack = json['slack'];
  }
}

class _Limits {
  int? employee;
  int? kiosk;
  int? printer;
  int? visitorType;
  int? desk;

  _Limits.fromJson(Map<String, dynamic> json) {
    employee = json['Employee'];
    kiosk = json['Kiosk'];
    printer = json['Printer'];
    visitorType = json['VisitorType'];
    desk = json['Desk'];
  }
}
