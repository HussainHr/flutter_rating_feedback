import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rating_feedback/flutter_rating_feedback.dart';

void main() {
  test('FeedbackData model test', () {
    final feedback = FeedbackData(
      rating: 5,
      comment: 'Great app!',
      userEmail: 'test@example.com',
    );

    expect(feedback.rating, 5);
    expect(feedback.comment, 'Great app!');
    expect(feedback.userEmail, 'test@example.com');

    final json = feedback.toJson();
    expect(json['rating'], 5);
    expect(json['comment'], 'Great app!');
  });

  test('RatingConfig default values', () {
    const config = RatingConfig();

    expect(config.title, 'Rate Your Experience');
    expect(config.submitButtonText, 'Submit Feedback');
    expect(config.showEmailField, true);
  });
}