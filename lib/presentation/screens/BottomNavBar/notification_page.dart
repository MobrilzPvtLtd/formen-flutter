import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:dating/core/ui.dart';
import 'package:dating/language/localization/app_localization.dart';

class NotificationPage extends StatefulWidget {
  static const String notificationRoute = "/notificationPage";
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late HomeProvider homeProvider;

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).notificationApi();
  }

  @override
  void dispose() {
    super.dispose();
    homeProvider.isNotification = true;
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const BackButtons(),
        title: Text(
          AppLocalizations.of(context)?.translate("Notifications") ?? "Notifications",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: homeProvider.isNotification
          ? Center(child: CircularProgressIndicator(color: AppColors.appColor))
          : homeProvider.notificationModel.notificationData!.isEmpty
          ? Center(child: Lottie.asset('assets/lottie/notification.json'))
          : ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerTheme.color!),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(homeProvider.notificationModel.notificationData![index].title.toString(),
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text(homeProvider.notificationModel.notificationData![index].description.toString(),
                          style: Theme.of(context).textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
                Text(homeProvider.notificationModel.notificationData![index].datetime.toString().split(" ").first,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: homeProvider.notificationModel.notificationData!.length,
      ),
    );
  }
}
