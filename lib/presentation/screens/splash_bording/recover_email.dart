import 'package:dating/core/ui.dart';
import 'package:dating/presentation/widgets/main_button.dart';
import 'package:dating/presentation/widgets/sizeboxx.dart';
import 'package:dating/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import '../../../language/localization/app_localization.dart';
import '../../widgets/other_widget.dart';

class RecoverEmail extends StatefulWidget {
  static const String recoverEmailRoute = "/recoverEmail";
  const RecoverEmail({super.key});

  @override
  State<RecoverEmail> createState() => _RecoverEmailState();
}

class _RecoverEmailState extends State<RecoverEmail> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackButtons(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    // "Recover your account using your email address".tr,
                    AppLocalizations.of(context)?.translate("Recover your account using your email address") ?? "Recover your account using your email address",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(height: 1.9),
                    textAlign: TextAlign.center,
                  ),
                  const SizBoxH(size: 0.020),
                  TextFieldPro(
                      // controller: controller, hintText: "Example@gmail.com".tr),
                      controller: controller, hintText: AppLocalizations.of(context)?.translate("Example@gmail.com") ?? "Example@gmail.com"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade100.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(children: [
                          const SizedBox(
                            width: 50,
                          ),
                          Flexible(
                            child: Text(
                              // "We'll email you a link to connect to your account".tr,
                              AppLocalizations.of(context)?.translate("We'll email you a link to connect to your account") ?? "We'll email you a link to connect to your account",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: AppColors.appColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizBoxH(size: 0.040),
                // MainButton(title: "Continue".tr),
                MainButton(title: AppLocalizations.of(context)?.translate("Continue") ?? "Continue"),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
