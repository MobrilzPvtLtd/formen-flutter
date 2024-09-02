import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_sound/flutter_sound.dart'; // For audio recording
import 'package:intl/intl.dart';

// Assume you have these imports based on your project structure
import '../../../../api_data/chat_api.dart';
import '../../../../core/ui.dart'; // Ensure this path is correct

class ChatPage extends StatefulWidget {
  final String? receiverId;
  final String? senderId;
  final String? name;
  final String? senderName;

  ChatPage({Key? key, this.receiverId, this.senderId, this.name,this.senderName}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController chatText = TextEditingController();
  ScrollController controller = ScrollController();
  bool _sendingMessage = false;
  final ImagePicker _picker = ImagePicker();
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    getMessage(widget.receiverId, widget.senderId);
    chatListNotifier;
    _initAudioRecorder();
  }

  Future<void> _initAudioRecorder() async {
    // await _audioRecorder.openAudioSession();
  }

  @override
  void dispose() {
    chatText.dispose();
    controller.dispose();
    // _audioRecorder.closeAudioSession();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await sendMessage(widget.receiverId, widget.senderId, image.path);
    }
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final path = result.files.single.path;
      await sendMessage(widget.receiverId, widget.senderId, path!);
    }
  }

  // Future<void> _recordAudio() async {
  //   if (_isRecording) {
  //     final String path = await _audioRecorder.stopRecorder();
  //     await sendMessage(widget.receiverId, widget.senderId, path);
  //     setState(() {
  //       _isRecording = false;
  //     });
  //   } else {
  //     await _audioRecorder.startRecorder(toFile: 'audio_recording.aac');
  //     setState(() {
  //       _isRecording = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Material(
        child: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: chatListNotifier,
            builder: (BuildContext context, value, Widget? child) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                controller.animateTo(controller.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              });

              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      media.width * 0.05,
                      MediaQuery.of(context).padding.top + media.width * 0.05,
                      media.width * 0.05,
                      media.width * 0.05,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.appColor, Colors.black12],
                      ),
                    ),
                    height: media.height,
                    width: media.width,

                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: media.width * 0.9,
                              height: media.width * 0.1,
                              alignment: Alignment.center,
                              child: Text(
                                widget.name ?? "",
                                style: GoogleFonts.roboto(
                                  fontSize: media.width * 0.06,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Positioned(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, true);
                                },
                                child: Container(
                                  height: media.width * 0.1,
                                  width: media.width * 0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                      ),
                                    ],
                                    color: Colors.black,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.arrow_back),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                            valueListenable: chatListNotifier,
                            builder: (context, chatList, _) {
                              WidgetsBinding.instance?.addPostFrameCallback((_) {
                                scrollToBottom();
                              });

                              return ListView.builder(
                                controller: controller,
                                itemCount: chatList.length,
                                itemBuilder: (context, index) {
                                  final chatItem = chatList[index];
                                  bool isSentByUser = chatItem["sender_id"] == widget.senderId;
                                  // String timestamp = chatItem["created_at"];
                                  // DateTime dateTime = DateTime.parse(timestamp);
                                  // String formattedTime = DateFormat('HH:mm').format(dateTime);
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: media.width * 0.025),
                                        width: media.width * 0.9,
                                        alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment: isSentByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: media.width * 0.5,
                                              padding: EdgeInsets.all(media.width * 0.02),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: const Radius.circular(24),
                                                  bottomLeft: isSentByUser ? const Radius.circular(24) : const Radius.circular(0),
                                                  bottomRight: isSentByUser ? const Radius.circular(0) : const Radius.circular(24),
                                                  topRight: const Radius.circular(24),
                                                ),
                                                border:Border.all(width: 1,color: Colors.white54),
                                                color: isSentByUser ? Colors.white10 : Colors.black45,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // chatItem["sender_id"]==widget.senderId?Text("You",style: TextStyle(color: Colors.white54),): Text(widget.name ?? ""),
                                                    Text(
                                                      chatItem['message'] ?? "",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: media.width * 0.05,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: media.width * 0.015),
                                            // Uncomment if using timestamps
                                            // Text(formattedTime ?? ""),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: media.width * 0.025),
                          padding: EdgeInsets.fromLTRB(
                            media.width * 0.025,
                            media.width * 0.01,
                            media.width * 0.025,
                            media.width * 0.01,
                          ),
                          width: media.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey, width: 1.2),
                            color: Colors.black12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [

                                  // InkWell(
                                  //   onTap: _recordAudio,
                                  //   child: Icon(_isRecording ? Icons.stop : Icons.mic, color: Colors.black, size: media.width * 0.075),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                width: media.width * 0.6,
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: chatText,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Message',
                                    hintStyle: GoogleFonts.roboto(
                                      fontSize: media.width * 0.05,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  minLines: 1,
                                ),
                              ),
                              InkWell(
                                onTap: _pickImage,
                                child: Icon(Icons.camera_alt, color: Colors.white, size: media.width * 0.06),
                              ),
                              SizedBox(width: media.width * 0.02),
                              InkWell(
                                onTap: _pickDocument,
                                child: Icon(Icons.attach_file, color: Colors.white, size: media.width * 0.06),
                              ),
                              SizedBox(width: media.width * 0.02),
                              InkWell(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {
                                    _sendingMessage = true;
                                  });
                                  await sendMessage(widget.receiverId, widget.senderId, chatText.text);
                                  chatText.clear();
                                  setState(() {
                                    _sendingMessage = false;
                                  });
                                },
                                child: SizedBox(
                                  child: RotatedBox(
                                    quarterTurns: (Directionality.of(context) == TextDirection.RTL) ? 2 : 0,
                                    child: Icon(Icons.send, color: Colors.white, size: media.width * 0.06)
                                  ),
                                ),
                              ),
                              // Add emoji button here if needed
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_sendingMessage)
                    const Positioned(
                      top: 50,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
