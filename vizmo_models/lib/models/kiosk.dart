class Kiosk {
  String? kid;
  String? udid;
  bool? paired;
  String? passcode;
  String? cid;
  String? lid;
  String? totpSecret;
  String? name;
  bool? online;
  Kiosk({
    this.kid,
    this.udid,
    this.paired,
    this.passcode,
    this.cid,
    this.lid,
    this.totpSecret,
    this.name,
    this.online,
  });

  Map<String, dynamic> toMap() {
    return {
      'udid': udid,
      'paired': paired,
      'passcode': passcode,
      'cid': cid,
      'lid': lid,
      'totpSecret': totpSecret,
    };
  }

  factory Kiosk.fromMap(Map<String, dynamic> map) {
    return Kiosk(
      udid: map['udid'],
      paired: map['paired'] ?? false,
      passcode: map['passcode'],
      cid: map['cid'],
      lid: map['lid'],
      totpSecret: map['totpSecret'],
    );
  }

  @override
  String toString() {
    return 'Kiosk(udid: $udid, paired: $paired, passcode: $passcode, cid: $cid, lid: $lid, totpSecret: $totpSecret)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Kiosk &&
        o.udid == udid &&
        o.paired == paired &&
        o.passcode == passcode &&
        o.cid == cid &&
        o.lid == lid &&
        o.totpSecret == totpSecret;
  }

  @override
  int get hashCode {
    return udid.hashCode ^
        paired.hashCode ^
        passcode.hashCode ^
        cid.hashCode ^
        lid.hashCode ^
        totpSecret.hashCode;
  }
}
