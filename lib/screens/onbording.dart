

// Import the necessary libraries.
import 'package:flutter/material.dart';

// Create the onboarding screen widget.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Add a header section with a title and subtitle.
          Container(
            padding: const EdgeInsets.all(32),
            child: const Column(
              children: [
                Text(
                  "Welcome to the App",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Let's get you started with a few quick steps.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Add a list of onboarding pages.
          Expanded(
            child: PageView(
              children:const [
                // Create each onboarding page.
                  OnboardingPage(
                  title: "Step 1: Create an Account",
                  description: "Sign up for an account to access all the features of the app.",
                  image: "assets/images/onboarding_1.png",
                ),
                  OnboardingPage(
                  title: "Step 2: Personalize Your Profile",
                  description: "Add your profile picture, name, and other information to make the app more personal.",
                  image: "assets/images/onboarding_2.png",
                ),
                OnboardingPage(
                  title: "Step 3: Connect with Friends",
                  description: "Find and add friends to connect with and share your experiences.",
                  image: "assets/images/onboarding_3.png",
                ),

                // Add a final page with a button to start using the app.
                FinishOnboardingPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Create a widget for each onboarding page.
class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingPage({super.key, 
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 250,
          height: 250,
        ),
        const SizedBox(height: 32),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

// Create a widget for the final onboarding page.
class FinishOnboardingPage extends StatelessWidget {
  const FinishOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "You're all set!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Tap the button below to start using the app.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            // Navigate to the home screen.
            Navigator.pushNamed(context, "/home");
          },
          child: const Text("Start Using the App"),
        ),
      ],
    );
  }
}