//input_screen.dart
import 'package:flutter/material.dart';
import 'api_service.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final goalController = TextEditingController();
  final timelineController = TextEditingController();
  final foodHabitsController = TextEditingController();

  bool useGemini = false;
  String recommendations = '';

  void generatePlan() async {
    ApiService apiService = ApiService(); // Assuming ApiService handles both real and dummy data

    try {
      String response;
      
      if (useGemini) {
        // Call Gemini API and update recommendations
        response = await apiService.getRecommendations(
          height: heightController.text,
          weight: weightController.text,
          goal: goalController.text,
          timeline: timelineController.text,
          foodHabits: foodHabitsController.text,
        );
      } else {
        // Call dummy recommendations method
        response = await apiService.getDummyRecommendations();
      }

      setState(() {
        recommendations = response;
      });
    } catch (e) {
      setState(() {
        recommendations = 'Error occurred while fetching recommendations.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Health App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: heightController,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
              ),
              TextField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
              ),
              TextField(
                controller: goalController,
                decoration:
                    const InputDecoration(labelText: 'Weight Loss Goal (kg)'),
              ),
              TextField(
                controller: timelineController,
                decoration:
                    const InputDecoration(labelText: 'Timeline (Months)'),
              ),
              TextField(
                controller: foodHabitsController,
                decoration: const InputDecoration(labelText: 'Food Habits'),
              ),
              CheckboxListTile(
                title: const Text('Use Gemini AI'),
                value: useGemini,
                onChanged: (value) {
                  setState(() {
                    useGemini = value!;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: generatePlan,
                child: const Text('Get Recommendations'),
              ),
              const SizedBox(height: 100),
              const Text('Recommendations:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(recommendations),
            ],
          ),
        ),
      ),
    );
  }
}
