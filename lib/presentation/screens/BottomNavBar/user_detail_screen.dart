import 'package:dating/presentation/screens/BottomNavBar/chats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/homemodel.dart';

class ProfileScreen extends StatefulWidget {
  static const String profileScreenRoute = "/profileScreen";
  final Profilelist profile;
  @override
  ProfileScreen({required this.profile});

  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showAge = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF1F1F1F),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SectionTitle(title: 'Profile Information'),
            ),
            _buildProfileItem(
                title: 'Name', subtitle: widget.profile.profileName!),
            _buildProfileItem(
                title: 'About Me', subtitle: widget.profile.profileBio!),
            _buildProfileItem(
                title: 'My Tags',
                subtitle: 'Add keywords to be easily found...'),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ChatScreen()));
              },
              child: _buildProfileItem(
                  title: 'Chats', subtitle: "let's talk together"),
            ),
            Container(
              color: Colors.black,
              height: 70,
              child: const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Text('Statistics'),
                  ],
                ),
              ),
            ),
            SwitchListTile(
              activeTrackColor: Colors.yellow,
              activeColor: Colors.white,
              title:
                  const Text('Show Age', style: TextStyle(color: Colors.white)),
              value: showAge,
              onChanged: (bool value) {
                setState(() {
                  showAge = value;
                });
              },
            ),
            _buildProfileItem(
                title: 'Age', trailing: widget.profile.profileAge!.toString()),
            _buildProfileItem(title: 'Height'),
            _buildProfileItem(title: 'Weight'),
            _buildProfileItem(title: 'Body Type'),
            _buildProfileItem(title: 'Position'),
            _buildProfileItem(title: 'Ethnicity'),
            _buildProfileItem(title: 'Current Relationship'),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SectionTitle(title: 'Expectations'),
              ),
            ),
            _buildExpectationItem(title: 'Looking For', trailing: 'None'),
            _buildExpectationItem(title: 'Meetup Place', trailing: 'None'),
            _buildExpectationItem(
                title: 'Accept NSFW Photos', trailing: 'None'),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SectionTitle(title: 'Identity'),
              ),
            ),
            _buildNavigationItem(title: 'Sex'),
            _buildNavigationItem(title: 'Pronouns'),
            Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SectionTitle(title: 'Health'),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const Divider(color: Color(0xFF545454)),
                itemCount: 4,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return _buildHealthItem(
                        title: 'HIV Test',
                        subtitle:
                            'Insert your HIV status to add the date of the last test.',
                        trailing: 'Insert test date',
                      );
                    case 1:
                      return _buildHealthItem(
                        title: 'Test Reminders',
                        subtitle:
                            'A reminder will be displayed in your Grindr inbox at the specified time.',
                        trailing: 'Disabled',
                      );
                    case 2:
                      return _buildHealthNavigationItem(
                        title: 'Vaccines',
                      );
                    case 3:
                      return _buildHealthNavigationItem(
                        title: 'Sexual Health Questions',
                        subtitle:
                            'Learn more about HIV, PrEP, how to test for STIs, Grindr\'s commitment to privacy, and other FAQs.',
                      );
                    default:
                      return Container();
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required String title,
    String? subtitle,
    String? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70),
                  )
                : null,
            trailing: trailing != null
                ? Text(
                    trailing,
                    style: const TextStyle(color: Colors.grey),
                  )
                : null,
          ),
          const Divider(color: Color(0xFF545454)),
        ],
      ),
    );
  }

  Widget _buildExpectationItem({
    required String title,
    String? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            trailing: trailing != null
                ? Text(
                    trailing,
                    style: const TextStyle(color: Colors.grey),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required String title,
    String? subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: GestureDetector(
        onTap: () {
          // Handle navigation
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      style: const TextStyle(color: Colors.white70),
                    )
                  : null,
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Color(0xFF545454)),
            ),
            const Divider(color: Color(0xFF545454)),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthItem({
    required String title,
    required String subtitle,
    required String trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.white70, fontSize: 14.0),
        ),
        const SizedBox(height: 4.0),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            trailing,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthNavigationItem({
    required String title,
    String? subtitle,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle navigation
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4.0),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 14.0),
            ),
          ],
          const SizedBox(height: 4.0),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_forward_ios, color: Color(0xFF545454)),
          ),
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
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            username,
            style: const TextStyle(color: Color(0xFF545454), fontSize: 14.0),
          ),
          const Divider(color: Color(0xFF545454)),
        ],
      ),
    );
  }
}
