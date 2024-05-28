// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/presentation/firebase/chatting_provider.dart';
import 'package:dating/presentation/firebase/pickup_callpage.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/widgets/appbarr.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../core/config.dart';
import '../../../core/ui.dart';
import '../../../language/localization/app_localization.dart';
import '../../../main.dart';
import '../../firebase/chat_page.dart';
import '../../firebase/chat_service.dart';

class ChatScreen extends StatefulWidget {
  static const chatScreenRoute = "/chatScreen";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChattingProvider chattingProvider;

  @override
  void initState() {
    super.initState();
    chattingProvider = Provider.of<ChattingProvider>(context,listen: false);
    chattingProvider.demo1(context).then((value) {
      chattingProvider.isLoadingchat = false;
    });
    chattingProvider.getblockklisttApi(context);
    chattingProvider.searchController.clear();
    chattingProvider.isSearch = false;
    // chattingProvider.isLoadingchat = true;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   chattingProvider.isLoadingchat = true;
  // }

  @override
  Widget build(BuildContext context) {

    chattingProvider = Provider.of<ChattingProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: appbarr(context, 'Chats'.tr,traling: InkWell(
      appBar: appbarr(
        context, AppLocalizations.of(context)?.translate("Chats") ?? "Chats",traling: InkWell(
          onTap: () {
            chattingProvider.updateIsSearch();
          },
          child: SvgPicture.asset("assets/icons/Search.svg",height: 22,width: 22,),
      ),
      ),
      body: SafeArea(
        child: chattingProvider.isLoadingchat ? Center(child: CircularProgressIndicator(color: AppColors.appColor)) : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              chattingProvider.isSearch ? TextField(
                  style: Theme.of(context).textTheme.bodySmall!,
                  controller: chattingProvider.searchController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      isDense: true,
                      hintStyle: Theme.of(context).textTheme.bodySmall!,
                      // hintText: "Search..".tr,
                      hintText: AppLocalizations.of(context)?.translate("Search..") ?? "Search..",
                      suffixIcon: InkWell(
                        onTap: () {
                          chattingProvider.updateIsSearch();
                        },
                        child: SizedBox(
                            height: 25,
                            width: 25,
                            child: Center(child: SvgPicture.asset("assets/icons/times.svg",height: 22,width: 22,colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn)))
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.appColor)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Theme.of(context).dividerTheme.color!))),
                  onChanged: (s) {
                    chattingProvider.searchIteam(s);
                  }) :  _buildUserList(),

              chattingProvider.userData.isEmpty ? const SizedBox() : chattingProvider.searchController.text.isEmpty ? Expanded(child: _buildUserList()) : chattingProvider.searchIndexList.isEmpty ? Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    // Text("User Not Found".tr,style: Theme.of(context).textTheme.bodySmall,),
                    Text(AppLocalizations.of(context)?.translate("User Not Found") ?? "User Not Found",style: Theme.of(context).textTheme.bodySmall,),
                  ],
                ),) : Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: chattingProvider.searchIndexList.length,
                  itemBuilder: (context, index) {
                    var result = chattingProvider.searchIndexList[index];
                    return ListTile(
                        dense: true,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingPage(
                            proPic: chattingProvider.searchiteams[result]["image"],
                            resiverUserId: chattingProvider.searchiteams[result]["uid"],
                            resiverUseremail: chattingProvider.searchiteams[result]["name"],
                          ),));
                        },
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        leading: chattingProvider.searchiteams[result]["image"] == "null"
                            ? const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            backgroundImage: AssetImage(
                              "assets/Image/05.png",
                            ))
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 25,
                                backgroundImage: NetworkImage("${Config.baseUrl}${chattingProvider.searchiteams[result]["image"]}")),
                        title: Text(
                          chattingProvider.searchiteams[result]["name"],
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                        subtitle: Text(
                            chattingProvider.searchiteams[result]["message"],
                            style: Theme.of(context).textTheme.bodySmall
                        ),
                        trailing: Text(
                            DateFormat('hh:mm a')
                                .format(DateTime.fromMicrosecondsSinceEpoch(
                                chattingProvider.searchiteams[result]["timestamp"].microsecondsSinceEpoch))
                                .toString(),
                            style: const TextStyle(
                              fontSize: 10,
                            ))
                    );
                  },
                ),
               ),

              // Expanded(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset("assets/icons/emptyimage.png",height: 100,width: 100),
              //       const SizedBox(height: 10,),
              //       // Text("No contact, yet.".tr,style: Theme.of(context).textTheme.headlineSmall,),
              //       Text(AppLocalizations.of(context)?.translate("No contact, yet.") ?? "No contact, yet.",style: Theme.of(context).textTheme.headlineSmall),
              //       // Text("No messages in your inbox.Start chatting with people around you.".tr,style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center),
              //       Text(AppLocalizations.of(context)?.translate("No messages in your inbox.Start chatting with people around you.") ?? "No messages in your inbox.Start chatting with people around you.",style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center),
              //     ],),
              // )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("datingUser").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return  Center(
            child: Column(
              children: [
               const SizedBox(height: 150,),
                Lottie.asset('assets/lottie/no_text.json'),
               const Text("No users found!!!")
              ],
            ),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return _buildUserListIteam(snapshot.data!.docs[index], snapshot.data!.docs.length);
            },
          ),
        );
      },
    );
  }






  Widget _buildMessageiteam(document,String email, String uid, String proPic, int legnth,var snapshot) {

    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // List compere = [uid];
    // List apilist = [chattingProvider.getblockListApi.blockByMe?.join(","),chattingProvider.getblockListApi.blockByOther?.join(",")];
    List apilist = [];

    apilist.addAll(chattingProvider.getblockListApi.blockByMe as Iterable);
    apilist.addAll(chattingProvider.getblockListApi.blockByOther as Iterable);
    print("  + + + + :---  $apilist");


    if (chattingProvider.searchiteams.length < legnth - 1) {
      if (snapshot.data!.docs.isNotEmpty) {
        chattingProvider.searchiteams.add({
          "name": email,
          "image": proPic,
          "uid": uid,
          "message": data["message"],
          "timestamp": data["timestamp"]
        });
      }
    }
    return apilist.contains(uid) ? const SizedBox() : ListTile(
      dense: true,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChattingPage(
            proPic: proPic,
            resiverUserId: uid,
            resiverUseremail: email,
          ),));
        },
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
        leading: proPic == "null"
            ? const CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 25,
            backgroundImage: AssetImage(
              "assets/Image/05.png",
            ))
            : CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 25,
            backgroundImage: NetworkImage("${Config.baseUrl}$proPic"),
        ),
        title: Text(
          email,
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
        subtitle: Text(
          data["message"],
          style: Theme.of(context).textTheme.bodySmall
        ),
        trailing: Text(
            DateFormat('hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(data["timestamp"].microsecondsSinceEpoch)).toString(),
            style: const TextStyle(
              fontSize: 10,
            )
        )
    );
  }

  ChatServices chatservices = ChatServices();

  Widget _buildUserListIteam(DocumentSnapshot document, int legth) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    var uid = Provider.of<HomeProvider>(context,listen: false).uid;
    List ids = [data["uid"],uid];
    // ids.sort();
    // print(" + + + + + :------   ${data["pro_pic"]}");
    print(" + + + + + :------   ${document.data()}");

    if (Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name != data["name"]){
      return StreamBuilder(
          stream: chatservices.getMessage(userId: data["uid"], otherUserId: Provider.of<HomeProvider>(context,listen: false).uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error${snapshot.error}",style: Theme.of(context).textTheme.bodySmall);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            } else {
              return snapshot.data!.docs.isEmpty ? const SizedBox() : _buildMessageiteam(snapshot.data!.docs.last, data["name"], data["uid"], data["pro_pic"].toString(), legth,snapshot);
            }
          });
       }else{
        return const SizedBox();
    }
  }
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void listenFCM() async {

}

void requestPermission() async {



}

Future<void> initializeNotifications() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {

      print(" 0 0 0 11 0 0 0 11 0 0 0 11 0 0 0 11 0 0 0 $payload");

      if (payload != null) {

        Map data = jsonDecode(payload);

          if(data["vcId"] == "null" && data["Audio"] == "null") {

            navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => ChattingPage(resiverUserId: data["id"], resiverUseremail: data["name"], proPic: data["propic"]),));

          } else if(data["vcId"] != null && data["Audio"] == "null") {

            navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => PickUpCall(userData: data,isAudio: false),));

          } else if(data["Audio"] != null) {

            navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => PickUpCall(userData: data,isAudio: true),));

         }

      }
    },
  );
}

void loadFCM() async {

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      enableVibration: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation< AndroidFlutterLocalNotificationsPlugin >()?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

  }

}