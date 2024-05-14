import 'package:dating/presentation/screens/other/profileScreen/profile_provider.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../language/localization/app_localization.dart';

class FaqPage extends StatefulWidget {
  static const String faqRoute = "/faqPage";
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  late ProfileProvider profileProvider;
  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: const BackButtons(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(
          // "Faq".tr,
          AppLocalizations.of(context)?.translate("Faq") ?? "Faq",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(profileProvider.faqModel.faqData![index].question.toString(),style: Theme.of(context).textTheme.bodyMedium),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(profileProvider.faqModel.faqData![index].answer.toString(),style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: profileProvider.faqModel.faqData!.length)
          ],
        ),
      ),
    );
  }
}
