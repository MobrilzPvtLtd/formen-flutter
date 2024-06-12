import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumsTab extends StatefulWidget {
  @override
  _AlbumsTabState createState() => _AlbumsTabState();
}

class _AlbumsTabState extends State<AlbumsTab> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        AlbumTile('Create album', Icons.lock),
        AlbumTile('De fora 😈', Icons.person),
        AlbumTile('Album 1', Icons.photo_album),
      ],
    );
  }
}

class AlbumTile extends StatefulWidget {
  final String title;
  final IconData icon;

  AlbumTile(this.title, this.icon);

  @override
  _AlbumTileState createState() => _AlbumTileState();
}

class _AlbumTileState extends State<AlbumTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlbumDetailScreen(widget.title)),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 50),
            Text(widget.title,),
          ],
        ),
      ),
    );
  }
}

class AlbumDetailScreen extends StatefulWidget {
  final String title;

  AlbumDetailScreen(this.title);

  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(9, (index) {
          return Card(
            child: Image.network(
              'https://via.placeholder.com/150',
              fit: BoxFit.cover,
            ),
          );
        }),
      ),
    );
  }
}