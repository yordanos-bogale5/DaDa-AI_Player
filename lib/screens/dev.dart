// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyDeveloper());
}

class Developer {
  final String name;
  final String description;
  final String github;
  final String linkedIn;
  final String email;
  final String phone;

  Developer({
    required this.name,
    required this.description,
    required this.github,
    required this.linkedIn,
    required this.email,
    required this.phone,
  });
}

class DetailScreen extends StatelessWidget {
  final Developer developer;

  const DetailScreen(this.developer, {super.key} );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developed By'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.black, // Dark background color
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopSection(),
              _buildDetailsSection(),
              _buildAdditionalDetailsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/photo_2024-01-12_23-02-27.jpg', // Replace with your image asset
            fit: BoxFit.cover,
            height: 200.0,
            width: 200.0,
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.black.withOpacity(0.5),
          padding: const EdgeInsets.all(16.0),
          child: Text(
            developer.name,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            developer.description,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          const SizedBox(height: 18.0),
          _buildSectionTitle('Contact Me'),
          _buildContactInfo('Email', Icons.email, developer.email),
          _buildContactInfo('Phone', Icons.phone, developer.phone),
          _buildContactInfo('GitHub', Icons.link, developer.github),
          _buildContactInfo('LinkedIn', Icons.link, developer.linkedIn),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String label, IconData icon, String value) {
    return InkWell(
      onTap: () {
        if (label == 'GitHub' || label == 'LinkedIn') {
          _launchURL(value);
        }
        // Add more actions for other contact information if needed
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(height: 10.0),
         
          _buildSectionTitle('About Me'),

         
          const Text(
            'I am a passionate Flutter developer with a strong background in mobile app development. '
            'My goal is to create efficient, scalable, and visually appealing applications that provide '
            'a great user experience. I love learning and exploring new technologies to stay up-to-date '
            'with the ever-evolving tech landscape.',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),

          const SizedBox(height: 16.0),
          _buildSectionTitle('Skills'),
          _buildSkillsList(['Flutter', 'Dart', 'Python', 'Django', 'Firebase', 'Javascript','VueJs','Golang/Gin', 'PostgresDB','UI/UX Design']),

          const SizedBox(height: 16.0),
          _buildSectionTitle('Projects'),
          _buildProjectsList([
            'E-Learning Mobile App (Current Project)',
            'Exit Exam App',
            'AI integrated Music player App',
            'Expense Tracking System',
          ]),

          const SizedBox(height: 16.0),
          _buildSectionTitle('Portfolio'),
          _buildPortfolioButton(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSkillsList(List<String> skills) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: skills
          .map(
            (skill) => Chip(
              label: Text(skill),
              backgroundColor: Colors.blue[900],
              labelStyle: const TextStyle(color: Colors.white),
            ),
          )
          .toList(),
    );
  }

  Widget _buildProjectsList(List<String> projects) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: projects
          .map(
            (project) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '• $project',
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPortfolioButton() {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the portfolio screen
        // You can replace the next line with your navigation logic
        print('Navigate to Portfolio');
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.blue[900],
      ),
      child: const Text('View Portfolio'),
    );
  }

  // Open URL in browser
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class MyDeveloper extends StatelessWidget {
  const MyDeveloper({super.key});

  

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetailScreen(
        Developer(
          name: 'Yordanos Bogale',
          description:  'Software Engineer | Flutter Developer | Ex intern @CREAVERS Service PLC & @AAiT | 5th year Software Engineering Student @AMU',
          github: 'https://github.com/yordanos-bogale5',
          linkedIn: 'https://www.linkedin.com/in/yordanos-bogale/',
          email: 'bogaleyordanos64@gmail.com',
          phone: '+251919709237',
        ),
      ),
    );
  }


}
