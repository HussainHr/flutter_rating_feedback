class FeedbackData {
  final int rating;
  final String comment;
  final String userEmail;
  final DateTime timestamp;
  final Map<String, dynamic>? additionalData;

  FeedbackData({
    required this.rating,
    required this.comment,
    this.userEmail = '',
    DateTime? timestamp,
    this.additionalData,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'userEmail': userEmail,
      'timestamp': timestamp.toIso8601String(),
      'additionalData': additionalData,
    };
  }
}