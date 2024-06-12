
import 'package:dating/presentation/screens/BottomNavBar/Chat_screens/taps_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'album_screen.dart';
import 'message_screen.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inbox'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Messages',),
              Tab(text: 'Taps'),
              Tab(text: 'Albums'),
            ],
            labelStyle: TextStyle(fontSize: 16.0), // Increase the text size for selected tab
            unselectedLabelStyle: TextStyle(fontSize: 14.0),
          ),
        ),
        body: TabBarView(
          children: [
            MessagesTab(),
            TapsTab(),
            AlbumsTab(),
          ],
        ),
      ),
    );
  }
}





