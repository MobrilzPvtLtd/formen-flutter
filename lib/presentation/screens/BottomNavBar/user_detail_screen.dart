import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String profileScreenRoute = "/profileScreen";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SectionTitle(title: 'Health'),
          ListTile(
            title: Text('HIV Test'),
            subtitle: Text('Insert your HIV status to add the date of the last test.'),
            trailing: Text('Insert test date'),
          ),
          ListTile(
            title: Text('Test Reminders'),
            subtitle: Text('A reminder will be displayed in your Grindr inbox at the specified time.'),
            trailing: Text('Disabled'),
          ),
          ListTile(
            title: Text('Vaccines'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle navigation to vaccines screen
            },
          ),
          ListTile(
            title: Text('Sexual Health Questions'),
            subtitle: Text('Learn more about HIV, PrEP, how to test for STIs, Grindr\'s commitment to privacy, and other FAQs.'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle navigation to sexual health questions screen
            },
          ),
          SizedBox(height: 20),
          SectionTitle(title: 'Social Links'),
          SocialLink(title: 'Instagram', username: 'barbeariaseuadao'),
          SocialLink(title: 'Spotify', username: 'Add your favorite music'),
          SocialLink(title: 'Twitter', username: 'barbeariaseuadao'),
          SocialLink(title: 'Facebook', username: 'barbeariaseuadao'),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SocialLink extends StatelessWidget {
  final String title;
  final String username;

  SocialLink({required this.title, required this.username});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(username),
    );
  }
}