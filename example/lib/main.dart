import 'package:flutter/material.dart';
import 'package:flutter_rating_feedback/flutter_rating_feedback.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rating Feedback Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating Feedback Example'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Test Your Rating Package',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // Default Rating Button
            ElevatedButton(
              onPressed: () async {
                final result = await RatingFeedbackWidget.show(context);

                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Thanks for rating ${result.rating} stars!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  print('Feedback: ${result.toJson()}');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Show Default Rating Widget'),
            ),

            SizedBox(height: 20),

            // Custom Rating Button
            ElevatedButton(
              onPressed: () async {
                final result = await RatingFeedbackWidget.show(
                  context,
                  config: RatingConfig(
                    title: 'Rate Our App',
                    subtitle: 'How was your experience?',
                    primaryColor: Colors.purple,
                    backgroundColor: Colors.grey[50]!,
                    starIcon: Icons.favorite,
                    submitButtonText: 'Send Feedback',
                  ),
                  additionalData: {
                    'userId': '12345',
                    'appVersion': '1.0.0',
                    'screen': 'home_page'
                  },
                );

                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Custom feedback received!'),
                      backgroundColor: Colors.purple,
                    ),
                  );
                  print('Custom Feedback: ${result.toJson()}');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Show Custom Rating Widget'),
            ),
          ],
        ),
      ),
    );
  }
}