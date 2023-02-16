class NotificationPayload {
  _Notification? notification;
  _NotificationData? data;

  NotificationPayload({
    this.notification,
    this.data,
  });

  factory NotificationPayload.fromMap(Map<String, dynamic> map) {
    return NotificationPayload(
      notification: map['notification'] != null
          ? _Notification.fromMap(map['notification'] as Map<String, dynamic>)
          : null,
      data: map['data'] != null
          ? _NotificationData.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class _Notification {
  String? title;
  String? body;

  _Notification({
    this.title,
    this.body,
  });

  factory _Notification.fromMap(Map<String, dynamic> map) {
    return _Notification(
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
    );
  }
}

class _NotificationData {
  String? product;
  String? module;
  String? action;
  String? event;
  String? logId;
  String? inviteId;
  String? lid;
  String? cid;
  String? message;

  _NotificationData({
    this.product,
    this.module,
    this.action,
    this.event,
    this.logId,
    this.inviteId,
    this.lid,
    this.cid,
    this.message,
  });

  factory _NotificationData.fromMap(Map<String, dynamic> map) {
    return _NotificationData(
      product: map['product'] != null ? map['product'] as String : null,
      module: map['module'] != null ? map['module'] as String : null,
      action: map['action'] != null ? map['action'] as String : null,
      event: map['event'] != null ? map['event'] as String : null,
      logId: map['logId'] != null ? map['logId'] as String : null,
      inviteId: map['inviteId'] != null ? map['inviteId'] as String : null,
      lid: map['lid'] != null ? map['lid'] as String : null,
      cid: map['cid'] != null ? map['cid'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }
}
