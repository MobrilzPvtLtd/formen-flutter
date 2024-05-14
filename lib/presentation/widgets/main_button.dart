import 'package:dating/core/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? bgColor;
  final String title;
  final Color? titleColor;
  final String? iconpath;
  final double? radius;
  const MainButton(
      {super.key,
      this.onTap,
      required this.title,
      this.bgColor,
      this.iconpath,
      this.titleColor, this.radius});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(backgroundColor: MaterialStatePropertyAll(bgColor),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 12)))),
        onPressed: onTap ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconpath?.isEmpty ?? true
                ? const SizedBox()
                : SvgPicture.asset(
                    iconpath!,
                    height: 25,
                  ),
            iconpath?.isEmpty ?? true
                ? const SizedBox()
                : const SizedBox(
                    width: 8,
                  ),
            Flexible(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: titleColor ?? AppColors.white),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ));
  }
}
