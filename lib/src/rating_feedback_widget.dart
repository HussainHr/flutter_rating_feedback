import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/feedback_data.dart';
import 'models/rating_config.dart';

class RatingFeedbackWidget {
  static Future<FeedbackData?> show(
      BuildContext context, {
        RatingConfig? config,
        Map<String, dynamic>? additionalData,
      }) async {
    return await showDialog<FeedbackData>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return _RatingDialog(
          config: config ?? const RatingConfig(),
          additionalData: additionalData,
        );
      },
    );
  }
}

class _RatingDialog extends StatefulWidget {
  final RatingConfig config;
  final Map<String, dynamic>? additionalData;

  const _RatingDialog({
    required this.config,
    this.additionalData,
  });

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<_RatingDialog> with TickerProviderStateMixin {
  int selectedRating = 0;
  final TextEditingController commentController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    commentController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: widget.config.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                widget.config.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.config.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                widget.config.subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Rating Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRating = index + 1;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        widget.config.starIcon,
                        size: 40,
                        color: index < selectedRating
                            ? widget.config.primaryColor
                            : Colors.grey[300],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Comment Field (show for low ratings or always if configured)
              if (_shouldShowCommentField())
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: widget.config.commentHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: widget.config.primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),

              if (_shouldShowCommentField()) const SizedBox(height: 16),

              // Email Field (show for low ratings or always if configured)
              if (_shouldShowEmailField())
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: widget.config.emailHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: widget.config.primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),

              if (_shouldShowEmailField()) const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        widget.config.cancelButtonText,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: selectedRating > 0 ? _handleSubmit : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.config.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        _getButtonText(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Determine if comment field should be shown
  bool _shouldShowCommentField() {
    if (!widget.config.showCommentField) return false;
    if (selectedRating == 0) return widget.config.alwaysShowFields;
    return selectedRating < widget.config.storeRedirectThreshold || widget.config.alwaysShowFields;
  }

  // Determine if email field should be shown
  bool _shouldShowEmailField() {
    if (!widget.config.showEmailField) return false;
    if (selectedRating == 0) return widget.config.alwaysShowFields;
    return selectedRating < widget.config.storeRedirectThreshold || widget.config.alwaysShowFields;
  }

  // Get dynamic button text based on rating
  String _getButtonText() {
    if (selectedRating == 0) return widget.config.submitButtonText;

    if (selectedRating >= widget.config.storeRedirectThreshold &&
        widget.config.playStoreUrl.isNotEmpty) {
      return widget.config.storeButtonText;
    }

    return widget.config.submitButtonText;
  }

  // Handle button press based on rating
  Future<void> _handleSubmit() async {
    if (selectedRating >= widget.config.storeRedirectThreshold &&
        widget.config.playStoreUrl.isNotEmpty) {
      // High rating - redirect to store
      await _launchStore();
    } else {
      // Low rating - collect feedback
      _submitFeedback();
    }
  }

  // Launch store URL
  Future<void> _launchStore() async {
    try {
      final uri = Uri.parse(widget.config.playStoreUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication, // Opens in external app
        );
        // Still collect the rating data
        _submitFeedback();
      } else {
        // If can't launch store, show error and collect feedback instead
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unable to open app store. Thank you for your rating!'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        _submitFeedback();
      }
    } catch (e) {
      // Error launching URL, collect feedback instead
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Thank you for your rating!'),
            backgroundColor: Colors.green,
          ),
        );
      }
      _submitFeedback();
    }
  }

  // Submit feedback data
  void _submitFeedback() {
    final feedbackData = FeedbackData(
      rating: selectedRating,
      comment: commentController.text.trim(),
      userEmail: emailController.text.trim(),
      additionalData: widget.additionalData,
    );

    Navigator.of(context).pop(feedbackData);
  }
}