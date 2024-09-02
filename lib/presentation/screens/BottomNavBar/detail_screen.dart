import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Logic/cubits/editProfile_cubit/editprofile_cubit.dart';
import '../../../Logic/cubits/onBording_cubit/onbording_cubit.dart';
import '../../../api_data/chat_api.dart';
import '../../../core/config.dart';
import '../../../data/models/homemodel.dart';
import '../other/editProfile/editprofile_provider.dart';
import 'Chat_screens/chat_detail_screen.dart';
class ProfileScreen extends StatefulWidget {
  final Profilelist profile;

  @override
  const ProfileScreen({super.key, required this.profile});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController chatText = TextEditingController();
  bool isTyping = false; // Add this flag
  late EditProfileProvider editProvider;
  bool _sendingMessage = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EditProfileCubit>(context).loadingState();
    initeStatee();
  }

  initeStatee(){
    editProvider = Provider.of<EditProfileProvider>(context,listen: false);
    editProvider.dataTransfer(context);
    BlocProvider.of<OnbordingCubit>(context).religionApi().then((value) {
      editProvider.valuInReligion(value.religionlist!);
      BlocProvider.of<OnbordingCubit>(context).relationGoalListApi().then((value) {
        editProvider.valuInrelationShip(value.goallist!);
        BlocProvider.of<OnbordingCubit>(context).languagelistApi().then((value) {
          editProvider.valuInLanguage(value.languagelist!);
          BlocProvider.of<OnbordingCubit>(context).getInterestApi().then((value) {
            editProvider.valuInIntrest(value.interestlist!);
            BlocProvider.of<EditProfileCubit>(context).compeltDataTransfer();
          });
        });
      });
    });
  }

  void _navigateToChatScreen() async{
    setState(() {
      _sendingMessage = true;
    });
    await sendMessage(widget.profile.profileId, editProvider.id.text, chatText.text);
    chatText.clear();
    setState(() {
      _sendingMessage = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatPage(
          name: widget.profile.profileName,
          receiverId: widget.profile.profileId,
          senderId: editProvider.id.text,
          senderName: editProvider.name.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.network(
                "${Config.baseUrl}/${widget.profile.profileImages![0]}",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'friends',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "status",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            widget.profile.profileDistance ?? "",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Icon(Icons.sync_alt, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Versatile • Chat, Dates, Friends',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'ABOUT ME',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.profile.profileBio ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'STATS',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.male, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Man',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'EXPECTATIONS',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Looking For Chat, Dates, Friends',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'HEALTH',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'HIV status ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: media.width * 0.91,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[850],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        children: [
                          SizedBox(
                            width: media.width * 0.5,
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              controller: chatText,
                              onChanged: (text) {
                                setState(() {
                                  isTyping = text.isNotEmpty;
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Say something...',
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: media.width * 0.05,
                                  color: Colors.grey,
                                ),
                              ),
                              minLines: 1,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: isTyping ? _navigateToChatScreen : null,
                            child: isTyping?Icon(
                              Icons.send,
                              color: Colors.orangeAccent,
                              size: media.width * 0.09,
                            ):SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
