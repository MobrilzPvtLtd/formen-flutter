import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({super.key});

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  File? imagefile;
  Future camera() async {
    final cameraFile = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 40);
    if (cameraFile == null) return;
    setState(() {
      imagefile = File(cameraFile.path);
      imagefile = File(cameraFile.path);
    });
  }

  Future galleryImage()async{
    final galleryImageFile= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 40);
    if (galleryImageFile == null) return;
      
    
    setState(() {
      imagefile = File(galleryImageFile.path);
      imagefile = File(galleryImageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Chats",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w700),),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  SizedBox(
                    width: width * 0.80,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xffff36a21))),
                          hintText: "Type Something",
                          hintStyle: TextStyle(color: Colors.grey[700],fontSize: 15),
                          filled: true,
                          fillColor: const Color.fromARGB(98, 255, 193, 7),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xffff36a21))),
                          suffixIcon: IconButton(
                              onPressed: () {
                                galleryImage();
                              },
                              icon: Icon(
                                Icons.attach_file,
                                color: Colors.grey[800],
                              )),
                          prefixIcon: IconButton(
                              onPressed: () {
                                camera();
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              )),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Color(0xffff36a21)))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: height * 0.06,
                    width: width * 0.12,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(98, 255, 193, 7),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 1, color: const Color(0xffff36a21))),
                    child: const Icon(
                      Icons.arrow_right_alt_rounded,
                      size: 30,
                    ),
                  ),
                ])
                // IconButton(onPressed: (){}, icon: Icon(Icons.send_rounded,color:Color(0xffff36a21),size: 50,))

                )
          ],
        ),
      ),
    );
  }
}
