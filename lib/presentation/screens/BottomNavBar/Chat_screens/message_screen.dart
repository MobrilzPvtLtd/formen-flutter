import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesTab extends StatefulWidget {
  @override
  _MessagesTabState createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  final List<Map<String, dynamic>> messages = [
    {'icon': Icons.person, 'title': 'Turista psvo', 'subtitle': 'Oi'},
    {'icon': Icons.photo, 'title': '.', 'subtitle': 'Foto recebida'},
    {'icon': Icons.person, 'title': 'Leon', 'subtitle': 'Salvador'},
    {'icon': Icons.person, 'title': 'Paulistano', 'subtitle': 'Oi'},
    {'icon': Icons.album, 'title': 'De fora 😈', 'subtitle': 'Álbum recebido'},
    {'icon': Icons.person, 'title': 'LG', 'subtitle': '😏'},
    {'icon': Icons.person, 'title': 'User', 'subtitle': 'E vc na foto do perfil?'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        final message = messages[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4.0), // Adjust border radius for square corners
            child: Container(
              color: Colors.grey.shade300, // Background color if there's no image
              width: 50.0,
              height: 50.0,
              child: Icon(message['icon'] as IconData),
            ),
          ),
          title: Text(message['title'] as String),
          subtitle: Text(message['subtitle'] as String),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
