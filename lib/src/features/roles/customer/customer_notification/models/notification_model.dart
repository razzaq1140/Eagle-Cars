class NotificationModel {
  final String type;
  final String title;
  final String timeAgo;
  final String icon;

  NotificationModel({
    required this.type,
    required this.title,
    required this.timeAgo,
    required this.icon,
  });

  // Factory method to create a NotificationModel from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      type: json['type'] as String,
      title: json['title'] as String,
      timeAgo: json['timeAgo'] as String,
      icon: json['icon'] as String,
    );
  }

  // Method to convert a NotificationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'timeAgo': timeAgo,
      'icon': icon,
    };
  }
}
