import 'package:dating/core/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginWithButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? bgColor;
  final Color? textColor;
  final String title;
  final String? iconpath;
  const LoginWithButton(
      {super.key,
      this.onTap,
      required this.title,
      this.bgColor,
      this.iconpath, this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: Theme.of(context)
            .outlinedButtonTheme
            .style!
            .copyWith(backgroundColor: MaterialStatePropertyAll(bgColor)),
        onPressed: onTap ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            iconpath?.isEmpty ?? true ? const SizedBox() : SvgPicture.asset(
                    iconpath!,
                    height: 25,
                  ),
            iconpath?.isEmpty ?? true ? const SizedBox() : const SizedBox(
                    width: 8,
                  ),
            // const Spacer(),
            const SizedBox(width: 10,),
            Expanded(
              flex: 6,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(color: textColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Spacer(),
          ],
        ));
  }
}
