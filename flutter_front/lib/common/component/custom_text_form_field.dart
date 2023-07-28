import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;

  final IconData? prefixIcon;

  final TextInputType keyboardType;

  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: CustomColor.backGroundSubColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.all(kPaddingMiddleSize),
                  child: Icon(
                    prefixIcon,
                    size: kIconMiddleSize,
                    color: CustomColor.subColor,
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: kPaddingMiddleSize),
                child: Text(
                  labelText ?? "",
                  style: kTextMainStyleSmall,
                ),
              ),
            ],
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            cursorColor: CustomColor.textMainColor,
            keyboardType: keyboardType,
            obscureText: keyboardType == TextInputType.visiblePassword,
            style: kTextMainStyleMiddle,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(
                bottom: kPaddingMiddleSize,
              ),
              hintText: hintText,
              hintStyle: kTextMainStyleMiddle.copyWith(
                color: CustomColor.textMainColor.withOpacity(0.5),
              ),
              filled: true,
              fillColor: CustomColor.backGroundSubColor,
            ),
          ),
        ],
      ),
    );
  }
}
