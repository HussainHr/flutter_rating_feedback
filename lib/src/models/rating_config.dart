import 'package:flutter/material.dart';

class RatingConfig {
  final String title;
  final String subtitle;
  final String emailHint;
  final String commentHint;
  final String playStoreUrl;
  final Color primaryColor;
  final Color backgroundColor;
  final IconData starIcon;
  final bool showEmailField;
  final bool showCommentField;
  final String submitButtonText;
  final String storeButtonText;
  final String cancelButtonText;
  final int storeRedirectThreshold;
  final bool alwaysShowFields;

  const RatingConfig({
    this.title = 'Rate Your Experience',
    this.subtitle = 'Your feedback helps us improve',
    this.emailHint = 'Your email (optional)',
    this.commentHint = 'Tell us more about your experience...',
    this.playStoreUrl = '',
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.starIcon = Icons.star,
    this.showEmailField = true,
    this.showCommentField = true,
    this.submitButtonText = 'Submit Feedback',
    this.storeButtonText = 'Rate on Store',
    this.cancelButtonText = 'Cancel',
    this.storeRedirectThreshold = 4, // 4+ stars redirect to store
    this.alwaysShowFields = false, // Show fields regardless of rating
  });
}