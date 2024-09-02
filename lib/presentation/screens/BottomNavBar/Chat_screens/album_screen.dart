import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class CreateAlbumScreen extends StatefulWidget {
  @override
  _CreateAlbumScreenState createState() => _CreateAlbumScreenState();
}

class _CreateAlbumScreenState extends State<CreateAlbumScreen> {
  TextEditingController _albumNameController = TextEditingController();
  List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImages.add(File(photo.path));
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedImages.addAll(images.map((image) => File(image.path)).toList());
      });
    }
  }

  Future<void> _createAlbum() async {
    if (_albumNameController.text.isEmpty || _selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter an album name and select images")),
      );
      return;
    }

    final directory = await getExternalStorageDirectory();
    final String albumName = _albumNameController.text;
    final String albumPath = path.join(directory!.path, albumName);

    final albumDir = Directory(albumPath);
    if (!await albumDir.exists()) {
      await albumDir.create(recursive: true);
    }

    for (var image in _selectedImages) {
      final String newImagePath = path.join(albumDir.path, path.basename(image.path));
      await image.copy(newImagePath);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Album '$albumName' created successfully!")),
    );

    setState(() {
      _selectedImages.clear();
      _albumNameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Album'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Add a photo to start your album',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: _selectedImages.isEmpty
                  ? CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              )
                  : Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _selectedImages
                    .map((image) => ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _albumNameController,
              decoration: const InputDecoration(
                labelText: 'Album Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Only you see the album name',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _takePhoto,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take Photo'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.black87,
                minimumSize: const Size(double.infinity, 50), // make it full width
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.photo_library),
              label: const Text('Media Library'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.black87,
                minimumSize:const Size(double.infinity, 50), // make it full width
              ),
            ),
           const SizedBox(height: 20),
             ElevatedButton(
              onPressed: _createAlbum,
               child: Text('Create Album'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.orange,
                minimumSize: const Size(double.infinity, 50), // make it full width
              ),
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle the action for "What's an Album?"
                },
                child: const Text(
                  "What's an Album?",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _albumNameController.dispose();
    super.dispose();
  }
}
