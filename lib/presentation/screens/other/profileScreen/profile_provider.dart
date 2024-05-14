import 'package:dating/core/api.dart';
import 'package:dating/core/config.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/data/models/faqmodel.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../../../../data/localdatabase.dart';
import '../../../../data/models/blocklistmodel.dart';
import '../../../../data/models/identi_verify_model.dart';
import '../../../../data/models/pageslist.dart';
import '../../../../data/models/profileimag.dart';
import '../../../../data/models/unblockapimodel.dart';
import '../../../../language/localization/app_localization.dart';
import '../../../firebase/chat_page.dart';
import '../../Splash_Bording/auth_screen.dart';

class ProfileProvider extends ChangeNotifier {
  List menuList = [
    {
      "title": "Settings",
      "icon": "assets/icons/Setting.svg",
      "iconShow": "1",
      "traling": "assets/icons/Arrow - Right 2.svg"
    },
    {"title": "Dark Mode", "icon": "assets/icons/Show.svg", "iconShow": "2"},

    {"title": "Pages", "icon": "assets/icons/Show.svg", "iconShow": "2"},
    {
      "title": "Help Center",
      "icon": "assets/icons/Info Square.svg",
      "iconShow": "1",
      "traling": "assets/icons/Arrow - Right 2.svg"
    },
    {
      "title": "Account & Security",
      "icon": "assets/icons/security.svg",
      "iconShow": "1",
      "traling": "assets/icons/Arrow - Right 2.svg"
    },
    {
      "title": "Language",
      "icon": "assets/icons/globe-earth.svg",
      "iconShow": "1",
      "traling": "assets/icons/Arrow - Right 2.svg"
    },
    {
      "title": "Invite Friends",
      "icon": "assets/icons/3 User.svg",
      "iconShow": "1",
      "traling": "assets/icons/Arrow - Right 2.svg"
    },
    {"title": "Delete Account", "icon": "assets/icons/trash-fill.svg", "iconShow": "0"},
    {"title": "Logout", "icon": "assets/icons/Logout.svg", "iconShow": "0"},
  ];


  PackageInfo? packageInfo;
  String? appName;
  String? packageName;

  void getPackage() async {
    //! App details get

    packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo!.appName;


    packageName = packageInfo!.packageName;

    notifyListeners();
  }

  bool isDartMode = false;

  changeMode() {
    isDartMode = !isDartMode;
    notifyListeners();
  }

  final Api _api = Api();
  late FaqModel faqModel;
  late PrivacyPolicy privacyPolicy;

 Future faqApi(context) async{
   Map data = {
     "uid" : Provider.of<HomeProvider>(context,listen: false).uid,
   };
    try{
      var response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.faq}",data: data);
      if(response.statusCode == 200){
        faqModel = FaqModel.fromJson(response.data);
        notifyListeners();
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  bool isLoading = false;
  Future pageListApi(context) async{
    try{
      var response = await _api.sendRequest.get("${Config.baseUrlApi}${Config.pageList}",);
      if(response.statusCode == 200){
        privacyPolicy = PrivacyPolicy.fromJson(response.data);
        isLoading = true;
        notifyListeners();
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future deleteAccountApi(context) async{

    Map data = {
      "uid" : Provider.of<HomeProvider>(context,listen: false).uid,
    };

    try{
      var response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.accDelete}",data: data);
      if(response.statusCode == 200){
        if(response.data["Result"] == "true"){
          isUserLogOut(Provider.of<HomeProvider>(context,listen: false).uid);
          Navigator.pushNamedAndRemoveUntil(context, AuthScreen.authScreenRoute,(route) => false,);
          Provider.of<HomeProvider>(context,listen: false).setSelectPage(0);
          Preferences.clear();
          await GoogleSignIn().signOut();
          await FacebookAuth.instance.logOut();
        }else{
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
        }
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future deleteButtomSheet(context){
   return showModalBottomSheet(
     context: context, builder: (context) {
     return Container(
       height: 225,
       width: MediaQuery.of(context).size.width,
       decoration:  BoxDecoration(
         color: Theme.of(context).scaffoldBackgroundColor,
         borderRadius: const BorderRadius.only(
           topLeft: Radius.circular(20),
           topRight: Radius.circular(20),
         ),
       ),
       child: Column(
         children: [
           const SizedBox(
             height: 20,
           ),
           Text(
               // "Delete Account".tr,
               AppLocalizations.of(context)?.translate("Delete Account") ?? "Delete Account",
               style: Theme.of(context).textTheme.headlineSmall
           ),
           const SizedBox(
             height: 20,
           ),
           Padding(
             padding: const EdgeInsets.symmetric(
               horizontal: 20,
             ),
             child: Divider(
               color: Theme.of(context).dividerTheme.color!,
             ),
           ),
           const SizedBox(
             height: 10,
           ),
           Text(
               // "Are you sure you want to delete account?".tr,
               AppLocalizations.of(context)?.translate("Are you sure you want to delete account?") ?? "Are you sure you want to delete account?",
               style: Theme.of(context).textTheme.bodyMedium
           ),
           const SizedBox(
             height: 10,
           ),
           Row(
             children: [
               Expanded(
                 child: InkWell(
                   onTap: () {
                     Navigator.pop(context);
                   },
                   child: Container(
                     height: 60,
                     margin: const EdgeInsets.all(15),
                     alignment: Alignment.center,
                     decoration: BoxDecoration(
                       border: Border.all(color:  Colors.grey),
                       // color: gradient.defoultColor.withOpacity(0.1),
                       borderRadius: BorderRadius.circular(45),
                     ),
                     child: Text(
                         // "Cancel".tr,
                         AppLocalizations.of(context)?.translate("Cancel") ?? "Cancel",
                         style: Theme.of(context).textTheme.bodyMedium
                     ),
                   ),
                 ),
               ),
               Expanded(
                   child: InkWell(
                     onTap: () {
                       deleteAccountApi(context);
                       // walletController.deletAccount();
                       // deleteAccountController.deleteAccountApi(uId: decodeUid["id"].toString()).then((value) {
                       //   Get.offAll(BoardingPage());
                       // });
                     },
                     child: Container(
                       height: 60,
                       margin: const EdgeInsets.all(15),
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                         color: AppColors.appColor,

                         borderRadius: BorderRadius.circular(45),
                       ),
                       child: Text(
                           // "Yes, Remove".tr,
                           AppLocalizations.of(context)?.translate("Yes, Remove") ?? "Yes, Remove",
                           style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white)
                       ),
                     ),
                   )
               )
             ],
           )
         ],
       ),
     );
   },);
}





  // BlockList api

  late BlocklistApi blocklistApi;

  Future blocklistaApi(context) async {

    Map data = {
      "uid" : Provider.of<HomeProvider>(context,listen: false).uid,
      "lats": Provider.of<HomeProvider>(context,listen: false).lat,
      "longs": Provider.of<HomeProvider>(context,listen: false).long,
    };

    try{
      var response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.blocklist}",data: data);
      if(response.statusCode == 200){
        blocklistApi = BlocklistApi.fromJson(response.data);
        isLoading = true;
        notifyListeners();
      }else{
        notifyListeners();
      }

    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }



// profile pic api


  late Profilepickimage profilepickimage;

  Future profilepicApi({required context,required String img}) async{

    Map data = {
      "uid" : Provider.of<HomeProvider>(context,listen: false).uid,
      "img": img
    };

    try{
      var response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.pro_pic}",data: data);
      print(" + + + + + + + + : ---------  ${response.data}");
      if(response.statusCode == 200){
        Profilepickimage.fromJson(response.data);
        if(response.data["Result"] == "true"){
          Preferences.saveUserDetails(response.data);
          Provider.of<HomeProvider>(context,listen: false).localData(context);
          notifyListeners();
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
        }else{
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
        }
      }else{
        Fluttertoast.showToast(msg: "Something went Wrong....!!!");
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong....!!!")));
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }



  // identidoc pic api


  late IdentiDoc identiDoc;

  Future identiverifyApi({required context,required String img}) async{

    Map data = {
      "uid" : Provider.of<HomeProvider>(context,listen: false).uid,
      "img": img
    };

    try{
      var response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.identifyapi}",data: data);
      print(" + + + + + + + + : ---------  ${response.data}");
      if(response.statusCode == 200){
        IdentiDoc.fromJson(response.data);
        if(response.data["Result"] == "true"){
          Preferences.saveUserDetails(response.data);
          Provider.of<HomeProvider>(context,listen: false).localData(context);
          notifyListeners();
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
        }else{
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
        }
      }else{
        // Fluttertoast.showToast(msg: "Something went Wrong....!!!".tr);
        Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Something went Wrong....!!!") ?? "Something went Wrong....!!!");
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong....!!!")));
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }






  // ProfileBlock api

  late UnBlockApi unBlockApi;

  Future unblockApi({required context,required String profileblock}) async {

    Map data = {
      "uid" : Provider.of<HomeProvider>(context,listen: false).uid,
      "profile_id": profileblock
    };

    try{
      var response = await _api.sendRequest.post("${Config.baseUrlApi}${Config.unblockapikey}",data: data);
      print(" + + + + + + + + : ---------  ${response.data}");
      if(response.statusCode == 200){
        UnBlockApi.fromJson(response.data);
        if(response.data["Result"] == "true"){
          // Preferences.saveUserDetails(response.data);
          // Provider.of<HomeProvider>(context,listen: false).localData(context);
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BottomBar()), (route) => false);
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
          notifyListeners();
        }else{
          Fluttertoast.showToast(msg: response.data["ResponseMsg"]);
        }
      }else{
        // Fluttertoast.showToast(msg: "Something went Wrong....!!!".tr);
        Fluttertoast.showToast(msg: AppLocalizations.of(context)?.translate("Something went Wrong....!!!") ?? "Something went Wrong....!!!");
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went Wrong....!!!")));
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }





  // secound api

  // Profilepickimage? profilepickimage;
  // bool Loading =true;
  // Future proImage(uid, image) async {
  //   Map body = {
  //     "uid" : uid,
  //     "img": image,
  //   };
  //   try {
  //     var response = await http.post(Uri.parse(Config.baseUrl + Config.proImage),
  //         body: jsonEncode(body),
  //         headers: {
  //           'Content-Type': 'application/json',
  //         });
  //     if (response.statusCode == 200) {
  //       setState(()  {
  //         proImageModal =proImageModalFromJson(response.body);
  //         Loading=false;
  //       });
  //       SharedPreferences preferences = await SharedPreferences.getInstance();
  //       preferences.setString('UserLogin', jsonEncode(proImageModal!.userLogin));
  //       preferences.setString('profilePic', networkImage);
  //       var data = jsonDecode(response.body.toString());
  //       return data;
  //     } else {}
  //   } catch (e) {}
  // }







}
