// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io' show File;

class Visitor {
  String? id;
  String? _name;
  String? email;
  String? phone;
  String? company;
  String? photoUri;
  String? idUri;
  String? idType;
  String? agreementUri;
  bool? agreementSigned = false;
  bool? verified = false;
  String? firstName;
  String? lastName;

  File? visitorPhotoFile;
  File? visitorIdFile;

  // String? get firstName {
  //   if (_firstName != null) return _firstName;
  //   final spaceIndex = name?.indexOf(' ') ?? -1;
  //   // if we don't have space in the name, then set the value to firstName.
  //   final firstName = spaceIndex < 0 ? name : name?.substring(0, spaceIndex);
  //   return firstName;
  // }

  // set firstName(String? firstName) {
  //   _firstName = firstName;
  // }

  // String? get lastName {
  //   if (_lastName != null) return _lastName;
  //   final spaceIndex = name?.indexOf(' ') ?? -1;

  //   final lastName = spaceIndex < 0 ? '' : name?.substring(spaceIndex);
  //   return lastName;
  // }

  // set lastName(String? lastName) {
  //   _lastName = lastName;
  // }

  String? get name {
    if (_name != null) return _name;

    return '$firstName $lastName';
  }

  set name(String? name) {
    if (name?.isEmpty ?? true) return;
    _name = name;
  }

  Visitor({
    this.id,
    // this.name,
    this.email,
    this.phone,
    this.company,
    this.photoUri,
    this.idUri,
    this.agreementUri,
    this.agreementSigned = false,
    this.verified = false,
    this.firstName,
    this.lastName,
  });

  Visitor.fromMap(Map<String, dynamic> map)
      : email = map['email'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        phone = map['phone'],
        company = map['company'],
        photoUri = map['photoUri'],
        idUri = map['idUri'],
        idType = map['idType'],
        agreementUri = map['agreementUri'],
        agreementSigned = map['agreementSigned'] ?? false,
        verified = map['verified'] ?? false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'company': company,
      'photoUri': photoUri,
      'idUri': idUri,
      'idType': idType,
      'agreementUri': agreementUri,
      'agreementSigned': agreementSigned,
      'verified': verified,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  bool operator ==(covariant Visitor other) {
    return (id?.isNotEmpty ?? false) && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ phone.hashCode;
  }
}
