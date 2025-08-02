class NotificationPayload {
  String? route;
  NotificationPayload({this.route});

  factory NotificationPayload.fromJson(Map<String, dynamic> json) {
    return NotificationPayload(
      route: json['route'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'route': route
    };
  }

}

