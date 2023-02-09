class Plans {
  String? id;
  bool? invites;
  Plans({
    this.id,
    this.invites,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invites': invites,
    };
  }

  factory Plans.fromMap(String id, Map<String, dynamic> map) {
    return Plans(
      id: id,
      invites: map['invites'],
    );
  }
}
