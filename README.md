    Flutter Rating Feedback
    Show Image
    Show Image
    Show Image
    A beautiful, customizable, and easy-to-use rating and feedback widget for Flutter applications. Collect user ratings and feedback with just one tap - perfect for app store ratings, user experience surveys, and customer feedback collection.
    ✨ Features
    
    ⭐ Interactive Star Rating - Smooth animated star selection
    💬 Optional Comment Field - Let users provide detailed feedback
    📧 Email Collection - Optionally collect user email addresses
    🎨 Fully Customizable - Colors, text, icons, and layout
    🔄 Smooth Animations - Beautiful entrance and interaction animations
    📱 Cross Platform - Works on iOS, Android, Web, and Desktop
    🚀 Easy Integration - Just one line of code to show the dialog
    📊 Structured Data - Get feedback data in a structured format
    🎯 Additional Metadata - Pass custom data for analytics
    💾 No Dependencies - Pure Flutter implementation
    
    Default ThemeCustom ThemeWith Email FieldShow ImageShow ImageShow Image
    🚀 Getting Started
    Installation
    Add this to your package's pubspec.yaml file:
    
    yaml
    dependencies:
    flutter_rating_feedback: ^0.0.1
    
    Then run:
    bash
    flutter pub get
    Import
    dart
    import 'package:flutter_rating_feedback/flutter_rating_feedback.dart';
    
    📋 Usage
    Basic Usage
    The simplest way to show a rating dialog:
    
    dart
    final result = await RatingFeedbackWidget.show(context);
    
    if (result != null) {
        print('User rated: ${result.rating} stars');
        print('Comment: ${result.comment}');
        print('Email: ${result.userEmail}');
    }
    
    Custom Configuration
    Customize the appearance and behavior:
    
    final result = await RatingFeedbackWidget.show(
        context,
        config: RatingConfig(
            title: 'Rate Our App',
            subtitle: 'Your feedback helps us improve',
            primaryColor: Colors.purple,
            backgroundColor: Colors.white,
            starIcon: Icons.favorite,
            showEmailField: true,
            showCommentField: true,
            submitButtonText: 'Send Feedback',
            cancelButtonText: 'Maybe Later',
        ),
        additionalData: {
            'userId': '12345',
            'appVersion': '1.0.0',
            'screen': 'home_page',
        },
    );
    
    📱 Platform Support
    
    ✅ Android - Fully supported
    ✅ iOS - Fully supported
    ✅ Web - Fully supported
    ✅ macOS - Fully supported
    ✅ Windows - Fully supported
    ✅ Linux - Fully supported
    
    🐛 Issues and Feedback
    If you encounter any issues or have suggestions:
    
    🐛 Report bugs
    💡 Request features
    📧 Email support
    
    📄 License
    This project is licensed under the MIT License - see the LICENSE file for details.
    🙋‍♂️ Author
    Hussainur Rahman
    📧 your.email@example.com
    🐦 @HussainHr
    🌟 Show Your Support
    Give a ⭐️ if this project helped you!
    
    Made with ❤️ and Flutter