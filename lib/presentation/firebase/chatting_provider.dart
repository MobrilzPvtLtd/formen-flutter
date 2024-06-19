// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/core/api.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/config.dart';
import '../../core/ui.dart';
import '../../data/models/getblocklistapimodel.dart';
import '../../language/localization/app_localization.dart';
import '../widgets/other_widget.dart';
import 'chat_bubble.dart';
import 'chat_service.dart';

class ChattingProvider extends ChangeNotifier{
TextEditingController searchController = TextEditingController();


bool isSearch = false;

bool isLoading = false;

updateIsLoading(bool value){
  isLoading = value;
  notifyListeners();
}

updateIsSearch(){
  isSearch =! isSearch;
  notifyListeners();
}
  String? uid;
  updateUid(String value){
    uid = value;
  }

  TextEditingController controller = TextEditingController();
  ChatServices chatservices = ChatServices();
  String fmctoken = "";

  Future<dynamic> isMeassageAvalable(String uid) async {
    CollectionReference collectionReference =  FirebaseFirestore.instance.collection('datingUser');
    collectionReference.doc(uid).get().then((value) {
      var fields;
      fields = value.data();
        fmctoken = fields["token"];
         notifyListeners();
    });
  }

List searchIndexList = [];
List<Map> searchiteams = [];

searchIteam(s){

  searchIndexList = [];

  for (int i = 0; i < searchiteams.length; i++) {
    if (searchiteams[i]["name"].toLowerCase().contains(s.toLowerCase())) {
      final ids = searchiteams.map<String>((e) => e['uid']!).toSet();

      searchiteams.retainWhere((Map x) {
        return ids.remove(x['uid']);
      });

  notifyListeners();
      searchIndexList.add(i);
    } else {
      notifyListeners();
    }
  }

}

List userData = [];
bool isLoadingchat = true;
Future demo1(context) async{
   userData.clear();
   Stream<QuerySnapshot<Map<String, dynamic>>> snep =  FirebaseFirestore.instance.collection("datingUser").snapshots();
   snep.forEach((element) {
 List<QueryDocumentSnapshot<Map<String, dynamic>>> data = element.docs;
 for(int a = 0;a<data.length;a++){
   Map<String, dynamic> dataa = data[a].data();
   print("* * :-- ${data[a].data()}");
   Stream<QuerySnapshot<Object?>> snapshot  = chatservices.getMessage(userId: dataa["uid"], otherUserId: Provider.of<HomeProvider>(context,listen: false).uid);
   snapshot.forEach((element) {
     List data = element.docs ;
     for(int a = 0; a < data.length; a++){
       Map dataa1  = data[a].data() as Map;
       if (Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name != dataa["name"]){
             userData.add({
               "name": dataa["name"],
               "image": dataa["pro_pic"],
               "uid": dataa["uid"],
               "message": dataa1["message"],
               "timestamp": dataa1["timestamp"]
             });
             notifyListeners();
       }
     }
     notifyListeners();
   });
   }
   });
}

  Widget buildMessageInpurt({required resiverUserId,required context}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: Theme.of(context).textTheme.bodyMedium!,
              controller: controller,
              decoration: InputDecoration(
                // fillColor: Colors.grey.shade100,
                // filled: true,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(12),
                  suffixIcon: InkWell(
                    onTap: () {
                      sendMessage(resiverUserId: resiverUserId, fmctoken: fmctoken, context: context);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 40,width: 40,decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.appColor,
                    ),
                      child: Center(child: SvgPicture.asset("assets/icons/Send.svg")),
                    ),
                  ),

                  // IconButton(
                  //   onPressed: () {
                  //     sendMessage(resiverUserId: resiverUserId, fmctoken: fmctoken, context: context);
                  //   },
                  //   icon:  const Icon(
                  //     Icons.send,
                  //   ),),

                  hintStyle: Theme.of(context).textTheme.bodySmall!,
                  // hintText: "Say Something..".tr,
                  hintText: AppLocalizations.of(context)?.translate("Say Something..") ?? "Say Something..",
                  fillColor: Theme.of(context).cardColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appColor),
                      borderRadius: BorderRadius.circular(12)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),
                      borderRadius: BorderRadius.circular(12))
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessageList({required String resiverUserId,required context}) {
    return StreamBuilder(
        stream: chatservices.getMessage(userId: resiverUserId, otherUserId: Provider.of<HomeProvider>(context,listen: false).uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10,);
                  },
                  itemBuilder: (context, index){
                    return Row(
                      mainAxisAlignment: index % 2 ==0 ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        commonSimmer(height: 50, radius: 20,width: 80,customGeometry:  BorderRadius.only(topRight: const Radius.circular(10),bottomLeft: Radius.circular(index % 2 ==0 ? 10 :0),topLeft: const Radius.circular(10),bottomRight: Radius.circular(index % 2 ==0 ?0 :10))),
                      ],
                    );
                  }
                )
              ],
            );
          } else {
            return ListView(
              controller: scrollController,
              children:  snapshot.data!.docs.isEmpty ? [SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    // Text("No messages here yet...".tr,style: Theme.of(context).textTheme.headlineSmall,),
                    Text(AppLocalizations.of(context)?.translate("No messages here yet...") ?? "No messages here yet...",style: Theme.of(context).textTheme.headlineSmall,),
                    const SizedBox(height: 5,),
                    // Text("Send a message or tap on the greeting below".tr,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center),
                    Text(AppLocalizations.of(context)?.translate("Send a message or tap on the greeting below") ?? "Send a message or tap on the greeting below",style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center),
                      const SizedBox(height: 12,),
                      Image.asset("assets/Image/Sticker.png",height: 200,width: 200,)
                  ],),
                ),
              )] :  snapshot.data!.docs.map((document) => buildMessageiteam(document,context)).toList(),
            );
          }
        });
  }



  final ScrollController scrollController = ScrollController(initialScrollOffset: 50.0);



  Widget buildMessageiteam(DocumentSnapshot document,context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollDown();
    });

    var alingmentt = (data["senderid"] == Provider.of<HomeProvider>(context,listen: false).uid) ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alingmentt,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
          (data["senderid"] == Provider.of<HomeProvider>(context,listen: false).uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [

            Text(data["senderEmail"],
                style: TextStyle(
                    fontSize: 12,
                    // fontFamily: FontFamily.gilroyLight,
                    color: AppColors.greyLight)),
            // Text(data["message"])
            const SizedBox(
              height: 5,
            ),

            ChatBubble(
              chatColor: (data["senderid"] == Provider.of<HomeProvider>(context,listen: false).uid)
                  ? AppColors.appColor
                  : Colors.grey.shade100,
              textColor: (data["senderid"] == Provider.of<HomeProvider>(context,listen: false).uid)
                  ? Colors.white
                  : Colors.black,
              message: data["message"],
              alingment: (data["senderid"] == Provider.of<HomeProvider>(context,listen: false).uid)
                  ? false
                  : true,
            ),

            const SizedBox(
              height: 5,
            ),

            Text(DateFormat('hh:mm a').format(DateTime.fromMicrosecondsSinceEpoch(data["timestamp"].microsecondsSinceEpoch)).toString(), style: const TextStyle(fontSize: 10,)),

          ],
        ),
      ),
    );
  }


  void sendMessage({required String resiverUserId,required String fmctoken,required context}) async {
    try{
      CollectionReference collectionReference = FirebaseFirestore.instance.collection('datingUser');
      if (controller.text.isNotEmpty) {
        collectionReference.doc(resiverUserId).get().then((value) async {

          // var fields;
          // fields = value.data();
          //
          // if (fields["isOnline"] == false) {
          //   sendPushMessage(controller.text, Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name ?? "", fmctoken,context);
          // } else {
          //   print("user online");
          // }
          // await chatservices.sendMessage(receiverId: resiverUserId, messeage: controller.text, context: context);
          // controller.clear();
          // scrollController.jumpTo(scrollController.position.maxScrollExtent);

          try{
            var fields;
            fields = value.data();
            if (fields["isOnline"] == false) {
              sendPushMessage(controller.text, Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name ?? "", fmctoken,context);

            } else {
              print("user online");
            }
            await chatservices.sendMessage(receiverId: resiverUserId, messeage: controller.text, context: context);
            controller.clear();
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }catch(e){
            // Fluttertoast.showToast(msg: "Something Want Wrong".tr);
            Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Something Want Wrong") ?? "Something Want Wrong");
          }

        });
      }
    }catch(e){
       // Fluttertoast.showToast(msg: "Something Want Wrong".tr);
       Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Something Want Wrong") ?? "Something Want Wrong");
    }

  }

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  final Api _api = Api();

  void sendPushMessage(String body, String title, String token,context) async {
    try {
      await _api.sendRequest.post(Config.notificationUrl,data: <String, dynamic>{
        'notification': <String, dynamic>{
          'body': body,
          'title': title,
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': Provider.of<HomeProvider>(context,listen: false).uid,
          'name': Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name,
          'propic': Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.otherPic.toString().split("\$;").first,
          'status': 'done'
        },
        "to": token,
      },options: Options(headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${Config.firebaseKey}',
      }));
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }


Future vcNotificationMessage(String body, String title, String token,context,String vcId) async {
  try {

    await _api.sendRequest.post(Config.notificationUrl,data: <String, dynamic>{
      'notification': <String, dynamic>{
        'body': body,
        'title': title,
      },
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': Provider.of<HomeProvider>(context,listen: false).uid,
        'name': Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name,
        'propic': Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.otherPic.toString().split("\$;").first,
        'vcId': vcId,
        'status': 'done'
      },
      "to": token,
    },options: Options(headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=${Config.firebaseKey}',
    }));
    print('done');
  } catch (e) {
    print("error push notification");
  }
}

Future audioNotificationMessage(String body, String title, String token,context,String vcId) async {
  try {

    await _api.sendRequest.post(Config.notificationUrl,data: <String, dynamic>{
      'notification': <String, dynamic>{
        'body': body,
        'title': title,
      },
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': Provider.of<HomeProvider>(context,listen: false).uid,
        'name': Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.name,
        'propic': Provider.of<HomeProvider>(context,listen: false).userlocalData.userLogin!.otherPic.toString().split("\$;").first,
        'Audio': vcId,
        'status': 'done'
      },
      "to": token,
    },options: Options(headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=${Config.firebaseKey}',
    }));
    print('done');
  } catch (e) {
    print("error push notification");
  }
}



  Future<dynamic> isUserOnlie(String uid, bool isonline) async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('datingUser');
    collectionReference.doc(uid).update({"isOnline": isonline});
  }

// GetBlockList api

late GetblockListApi getblockListApi;

Future getblockklisttApi(context) async {

  Map data = {
    "uid" : Provider.of<HomeProvider>(context,listen: false).uid,
  };

  try{
    var response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.getblockapi}",data: data);
    print("+ + + + + +:----- ${response.data}");
    if(response.statusCode == 200){
      getblockListApi = GetblockListApi.fromJson(response.data);
      // isLoading = true;
      notifyListeners();
    }else{
      notifyListeners();
    }

  }catch(e){
    Fluttertoast.showToast(msg: e.toString());
  }

}




}