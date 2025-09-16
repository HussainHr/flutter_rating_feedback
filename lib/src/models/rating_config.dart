import 'package:flutter/material.dart';

class RatingConfig {
  final String title;
  final String emailHint;
  final String commentHint;
  final String subtitle;
  final Color primaryColor;
  final Color backgroundColor;
  final IconData starIcon;
  final bool showEmailField;
  final bool showCommentField;
  final String submitButtonText;
  final String cancelButtonText;

  const RatingConfig({
    this.title = 'Rate Your Experience',
    this.subtitle = 'Your feedback helps us improve',
    this.emailHint = 'Your email (optional)',
    this.commentHint = 'Tell us more about your experience...',
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.starIcon = Icons.star,
    this.showEmailField = true,
    this.showCommentField = true,
    this.submitButtonText = 'Submit Feedback',
    this.cancelButtonText = 'Cancel',
  });
}