import 'package:flutter/material.dart';
import 'package:flutter_rating_feedback/flutter_rating_feedback.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rating Feedback Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleUsage(),
    );
  }
}

class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rating Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Basic usage with Play Store redirect
            ElevatedButton(
              onPressed: () => _showPlayStoreRating(context),
              child: Text('Rate with Play Store'),
            ),

            SizedBox(height: 20),

            // Advanced configuration
            ElevatedButton(
              onPressed: () => _showAdvancedRating(context),
              child: Text('Advanced Rating'),
            ),

            SizedBox(height: 20),

            // Always collect feedback
            ElevatedButton(
              onPressed: () => _showFeedbackOnly(context),
              child: Text('Feedback Only'),
            ),
          ],
        ),
      ),
    );
  }

  // Basic Play Store integration
  Future<void> _showPlayStoreRating(BuildContext context) async {
    final result = await RatingFeedbackWidget.show(
      context,
      config: RatingConfig(
        title: 'Enjoying Our App?',
        subtitle: 'Rate us on the Play Store!',
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.yourapp.package',
        storeRedirectThreshold: 4, // 4+ stars go to store
        primaryColor: Colors.green,
      ),
    );

    if (result != null) {
      print('Rating received: ${result.rating} stars');
      if (result.rating < 4) {
        // Handle low rating feedback
        _handleLowRating(result);
      }
    }
  }

  // Advanced configuration
  Future<void> _showAdvancedRating(BuildContext context) async {
    final result = await RatingFeedbackWidget.show(
      context,
      config: RatingConfig(
        title: 'How was your experience?',
        subtitle: 'Help us improve our service',
        playStoreUrl: 'https://apps.apple.com/app/your-app/id123456789', // iOS App Store
        storeRedirectThreshold: 5, // Only 5 stars go to store
        storeButtonText: 'Rate on App Store',
        submitButtonText: 'Send Feedback',
        primaryColor: Colors.purple,
        starIcon: Icons.favorite,
        commentHint: 'What can we do better?',
        emailHint: 'Email for follow-up (optional)',
        alwaysShowFields: false, // Only show fields for low ratings
      ),
      additionalData: {
        'userId': 'user123',
        'appVersion': '1.2.0',
        'feature': 'checkout_flow',
      },
    );

    if (result != null) {
      _processFeedback(result);
    }
  }

  // Feedback only (no store redirect)
  Future<void> _showFeedbackOnly(BuildContext context) async {
    final result = await RatingFeedbackWidget.show(
      context,
      config: RatingConfig(
        title: 'We Value Your Feedback',
        subtitle: 'Tell us about your experience',
        playStoreUrl: '', // No store URL = no redirect
        alwaysShowFields: true, // Always show comment/email fields
        primaryColor: Colors.orange,
      ),
    );

    if (result != null) {
      _processFeedback(result);
    }
  }

  // Handle low rating feedback
  void _handleLowRating(FeedbackData feedback) {
    print('Low rating received: ${feedback.rating}');
    print('Feedback: ${feedback.comment}');
    print('Email: ${feedback.userEmail}');

    // Send to customer support system
    // _sendToSupport(feedback);
  }

  // Process all feedback
  void _processFeedback(FeedbackData feedback) {
    print('Processing feedback: ${feedback.toJson()}');

    // Send to analytics
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'user_feedback',
    //   parameters: feedback.toJson(),
    // );

    // Send to backend
    // _sendToBackend(feedback);
  }
}