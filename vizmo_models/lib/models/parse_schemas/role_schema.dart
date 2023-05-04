// import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart'er.dart';
// import 'package:vizmo_models/models/parse_schemas/company_schema.dart';
// import 'package:vizmo_models/models/parse_schemas/location_schema.dart';
// import 'package:vizmo_models/models/parse_schemas/user_schema.dart';

// class RoleSchema extends ParseObject {
//   RoleSchema() : super(_className);

//   static const String _className = '_Role';

//   static const String nameKey = 'name';
//   static const String usersKey = 'users';
//   static const String rolesKey = 'roles';
//   static const String companyKey = 'company';
//   static const String locationKey = 'location';

//   String get name => get(nameKey);
//   ParseRelation<UserSchema> get users {
//     var result = get(usersKey);
//     if (result is ParseRelation) {
//       return result;
//     }
//     return ParseRelation<UserSchema>()..fromJson(result);
//   }

//   ParseRelation<RoleSchema> get roles {
//     var result = get(usersKey);
//     if (result is ParseRelation) {
//       return ParseRelation<RoleSchema>()..fromJson(result.toJson());
//     }
//     return ParseRelation<RoleSchema>()..fromJson(result);
//   }

//   CompanySchema get company {
//     var result = get(companyKey);
//     if (result is ParseObject) {
//       return CompanySchema()..fromJson(result.toJson(full: true));
//     }
    
//     return CompanySchema()..fromJson(result);
//   }

//   LocationSchema get location {
//     var result = get(locationKey);
//     if (result is ParseObject) {
//       return LocationSchema()..fromJson(result.toJson(full: true));
//     } else if (result is List && (result?.isNotEmpty ?? false)) {
//       return LocationSchema()..fromJson(result.first.toJson(full: true));
//     }
//     return LocationSchema()..fromJson(result);
//   }
// }
