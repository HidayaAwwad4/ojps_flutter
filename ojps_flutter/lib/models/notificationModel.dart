// models/notification_model.dart

class NotificationModel {
  final int id;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;
  final String redirectUrl;

  NotificationModel({
    required this.id,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    required this.redirectUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      message: json['message'] ?? '',
      type: json['type'] ?? '',
      isRead: json['is_read'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      redirectUrl: json['redirect_url'] ?? '',
    );
  }
}
