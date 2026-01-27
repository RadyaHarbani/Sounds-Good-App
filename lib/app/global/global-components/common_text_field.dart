import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sounds_good_app/common/helper/themes.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? fieldController;
  final bool obscureText;
  final Icon? prefixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final IconButton? suffixIcon;
  final Function? validator;
  final Function? onSubmitted;
  final Function? onChanged;
  final List<TextInputFormatter>? inputFormatter;

  CommonTextField({
    Key? key,
    this.fieldController,
    required this.obscureText,
    this.prefixIcon,
    required this.hintText,
    this.keyboardType,
    this.suffixIcon,
    this.validator,
    this.onSubmitted,
    this.onChanged,
    this.inputFormatter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final double width = mediaQuery.width;
    final double height = mediaQuery.height;
    return TextFormField(
      controller: fieldController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: tsBodyMediumRegular(context, blackColor),
      onFieldSubmitted: onSubmitted as void Function(String)?,
      onChanged: onChanged as void Function(String)?,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.05,
        ),
        filled: true,
        fillColor: greyColor.withValues(alpha: 0.05),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: blackColor, width: 1.5),
        ),
        hintText: hintText,
        hintStyle: tsBodyMediumRegular(
          context,
          greyColor.withValues(alpha: 0.5),
        ),
        suffixIcon: suffixIcon,
      ),
      cursorColor: blackColor,
      validator: validator as String? Function(String?)?,
      inputFormatters: inputFormatter,
    );
  }
}
