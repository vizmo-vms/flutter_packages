class InviteResponse {
  String? cid;
  String? lid;
  String? iid;
  String? attendeeId;
  String? inviteId;
  String? paths;
  String? inviteToken;
  InviteResponse({
    this.cid,
    this.lid,
    this.iid,
    this.attendeeId,
    this.inviteId,
    this.paths,
    this.inviteToken,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'cid': cid,
  //     'lid': lid,
  //     'iid': iid,
  //     'attendeeId': attendeeId,
  //   };
  // }

  factory InviteResponse.fromUrl(String url) {
    try {
      final _uri = Uri.parse(url);

      final _paths = _uri.pathSegments;
      final _querys = _uri.queryParameters;
      if (_paths.length >= 2)
        return InviteResponse(
          paths: _paths[0],
          iid: _paths[1],
          attendeeId: _querys['attendeeId'],
          inviteId: _querys['inviteId'],
          inviteToken: _querys['inviteToken'] ?? _querys['token'],
        );

      return InviteResponse();
    } catch (e) {
      return InviteResponse();
    }
  }

  bool get isValid =>
      ((attendeeId?.isNotEmpty ?? false) ||
          (inviteToken?.isNotEmpty ?? false)) &&
      (inviteId?.isNotEmpty ?? false);
}
