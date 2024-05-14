import 'package:dating/core/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class TextFieldPro extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextAlign? textalingn;
  final String? suffixIconPath;
  final String? prefixIconIconPath;
  final List<TextInputFormatter>? format;
  final int? maxline;
  final TextInputType? inputType;
  final void Function(String)? onChangee;
  final bool? readOnly;
  final bool? obscureText;
  final void Function()? ontapp;
  final void Function()? surfixOntap;
  final bool? enabledd;
  final Color? svgColor;
  const TextFieldPro(
      {super.key,
      required this.controller,
      required this.hintText,
      this.textalingn,
      this.suffixIconPath,
      this.onChangee,
      this.format,
      this.inputType,
      this.maxline,
      this.readOnly,
      this.ontapp,
      this.enabledd,
      this.prefixIconIconPath,
      this.surfixOntap,
      this.obscureText, this.svgColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onTap: ontapp ?? () {},
      maxLines: maxline ?? 1,
      obscureText: obscureText ?? false,
      enabled: enabledd ?? true,
      minLines: 1,
      inputFormatters: format ?? [],
      onChanged: onChangee,
      readOnly: readOnly ?? false,
      style: Theme.of(context).textTheme.bodyMedium,
      controller: controller,
      textAlign: textalingn ?? TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: inputType ?? TextInputType.name,
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
          filled: true,
          prefixIcon: prefixIconIconPath?.isNotEmpty ?? false
              ? SizedBox(
                  height: 25,
                  width: 25,
                  child: Center(
                    child: SvgPicture.asset(
                      prefixIconIconPath!,
                      height: 25,
                      width: 25,
                      colorFilter: ColorFilter.mode(Theme.of(context).indicatorColor, BlendMode.srcIn),
                    ),
                  ),
                )
              : null,
          suffixIcon: suffixIconPath?.isNotEmpty ?? false
              ? InkWell(
                  onTap: surfixOntap,
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Center(
                      child: SvgPicture.asset(
                        suffixIconPath!,
                        height: 25,
                        width: 25,
                        colorFilter: ColorFilter.mode(svgColor ?? Theme.of(context).indicatorColor, BlendMode.srcIn),

                      ),
                    ),
                  ),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: Theme.of(context).dividerTheme.color!),),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(color: AppColors.appColor),),
          isDense: true,
          contentPadding:const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall),
    );
  }
}
