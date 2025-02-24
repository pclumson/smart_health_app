//api_service.dart
import 'dart:core';
import 'package:google_generative_ai/google_generative_ai.dart';

class ApiService {
  final String apiKey = '';

  ApiService() {
    // Initialize Gemini in the constructor
    // Uncomment the following line if necessary
    // Gemini.init(apiKey: apiKey);
  }

  Future<String> getRecommendations({
    required String height,
    required String weight,
    required String goal,
    required String timeline,
    required String foodHabits,
  }) async {
    // Call the prompt stream initializer with parameters
    return await _initPromptStream(height, weight, goal, timeline, foodHabits);
  }

Future<String> _initPromptStream(String height, String weight,
      String goal, String timeline, String foodHabits) async {
    final prompt =
        'Generate a diet and exercise plan based on the following parameters: '
        'Height: $height, Weight: $weight, Goal: $goal, Timeline: $timeline, Food Habits: $foodHabits';

    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [Content.text(prompt)];

    // Await the asynchronous response
    final response = await model.generateContent(content); // Modify if necessary

    try {
      // Ensure generatedText is a non-null String
      final generatedText = response.text ?? ''; // Provide a default empty string if null
      return generatedText; // Return the generated text directly
    } catch (e) {
      print('Error processing response: $e');
      // Handle the error appropriately, e.g., return an empty string or throw an error
      return '';
    }
  }

  Future<String> getDummyRecommendations() async {
    return Future.value('This is a dummy recommendation for diet and exercise plan.');
  }
}
