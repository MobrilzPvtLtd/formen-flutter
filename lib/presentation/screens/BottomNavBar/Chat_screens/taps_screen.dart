import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TapsTab extends StatefulWidget {
  @override
  _TapsTabState createState() => _TapsTabState();
}

class _TapsTabState extends State<TapsTab> {
  final List<Map<String, String>> users = [
    {'name': 'Bull', 'distance': '556 m away'},
    {'name': 'Turista psvo', 'distance': '556 m away'},
    {'name': 'User', 'distance': '556 m de distância'},
    {'name': 'Bora', 'distance': '522 m de distância'},
    {'name': 'Paulistano', 'distance': '9 km de distância'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        final user = users[index];
        return ListTile(
          leading:  ClipRRect(
            borderRadius: BorderRadius.circular(4.0), // Adjust border radius for square corners
            child: Container(
              color: Colors.grey.shade300, // Background color if there's no image
              width: 50.0,
              height: 50.0,
              child: const Icon(Icons.person),
            ),
          ),
          title: Text(user['name']!),
          subtitle: Text(user['distance']!),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
