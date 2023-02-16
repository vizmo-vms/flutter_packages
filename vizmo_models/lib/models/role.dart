class Role {
  String? id;
  String? name;

  bool get isLocAdmin => name == 'location-admin';
  bool get isAdmin => name == 'admin';

  Role({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) map = {};

    return Role(
      id: map['id'],
      name: map['name'],
    );
  }
}
