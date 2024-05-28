import 'package:dating/core/ui.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../language/localization/app_localization.dart';

class push_notification_screen extends StatefulWidget {
  const push_notification_screen({Key? key}) : super(key: key);

  @override
  State<push_notification_screen> createState() => _push_notification_screenState();
}

class _push_notification_screenState extends State<push_notification_screen> {

  bool previusstate1 = false;
  bool previusstate2 = false;
  bool previusstate3 = false;
  bool previusstate4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: const BackButtons(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          title: Text(
            // "Push Notifications".tr,
            AppLocalizations.of(context)?.translate("Push Notifications") ?? "Push Notifications",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 20),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body:
        // profileProvider.isLoading
        //     ?
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    // child: Text('New Matches'.tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                    child: Text(AppLocalizations.of(context)?.translate("New Matches") ?? "New Matches",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  // subtitle: Text("You just got a new match.".tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 14)),
                  subtitle: Text(AppLocalizations.of(context)?.translate("You just got a new match.") ?? "You just got a new match.",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 14)),
                  trailing: CupertinoSwitch(
                    value: previusstate1,
                    activeColor: AppColors.appColor,
                    onChanged: (bool value) async {
                      setState(() {
                        previusstate1 = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    // child: Text('Message'.tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                    child: Text(AppLocalizations.of(context)?.translate("Message") ?? "Message",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  // subtitle: Text('Someone sent you a new message.'.tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 14)),
                  subtitle: Text(AppLocalizations.of(context)?.translate("Someone sent you a new message.") ?? "Someone sent you a new message.",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 14)),
                  trailing: CupertinoSwitch(
                    value: previusstate2,
                    activeColor: AppColors.appColor,
                    onChanged: (bool value) async {
                      setState(() {
                        previusstate2 = value;
                      });

                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    // child: Text('Message Likes'.tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                    child: Text(AppLocalizations.of(context)?.translate("Message Likes") ?? "Message Likes",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                    // child: Text('Message Likes'.tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                    // child: Text(AppLocalizations.of(context)?.translate("Message Likes") ?? "Message Likes",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  // subtitle: Text('Someone liked your message.'.tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 14)),
                  subtitle: Text(AppLocalizations.of(context)?.translate("Someone liked your message.") ?? "Someone liked your message.",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 14)),
                  trailing: CupertinoSwitch(
                    value: previusstate3,
                    activeColor: AppColors.appColor,
                    onChanged: (bool value) async {
                      setState(() {
                        previusstate3 = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    // child: Text('Super Likes'.tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                    child: Text(AppLocalizations.of(context)?.translate("Super Likes") ?? "Super Likes",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  // subtitle: Text('You`ve been Super Liked.'.tr,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 14)),
                  subtitle: Text(AppLocalizations.of(context)?.translate("You`ve been Super Liked.") ?? "You`ve been Super Liked.",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey,fontSize: 14)),
                  trailing: CupertinoSwitch(
                    value: previusstate4,
                    activeColor: AppColors.appColor,
                    onChanged: (bool value) async {
                      setState(() {
                        previusstate4 = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      // : Center(child: CircularProgressIndicator(backgroundColor: AppColors.appColor,)),
    );
  }
}
