import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedTextFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String? initialValue;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final IconData? iconData;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final TextAlign? textAlign;
  final Function()? suffixOnTap;
  final String? Function(String?)? validator;
  final Color? suffixIconColor;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final bool number;
  final bool isObscure;
  final bool isEnable;
  final int maxLines;

  const FeedTextFormField({
    super.key,
    this.textEditingController,
    this.focusNode,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.labelText,
    this.helperText,
    this.iconData,
    this.prefixIconData,
    this.suffixIconData,
    this.textAlign,
    this.suffixOnTap,
    this.hintText,
    this.hintTextStyle,
    this.textStyle,
    this.validator,
    this.suffixIconColor,
    this.fillColor,
    this.keyboardType,
    this.isObscure = false,
    this.number = false,
    this.isEnable = true,
    this.onTap,
    this.onFieldSubmitted,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        enabled: isEnable,
        maxLines: maxLines,
        initialValue: initialValue,
        controller: textEditingController,
        focusNode: focusNode,
        obscureText: isObscure,
        onChanged: onChanged,
        onSaved: onSaved,
        onTap: onTap,
        textAlign: textAlign == null ? TextAlign.start : textAlign!,
        style: textStyle,
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: keyboardType,
        inputFormatters: number
            ? [
                FilteringTextInputFormatter.digitsOnly,
              ]
            : null,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the radius as needed
          ),
          fillColor: fillColor,
          filled: true,
          icon: iconData != null ? Icon(iconData) : null,
          labelText: labelText,
          helperText: helperText,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          hintText: hintText,
          hintStyle: hintTextStyle,
          prefixIcon: prefixIconData != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 10.0),
                  child: Icon(
                    prefixIconData,
                    // color: AVLColors.primaryColor,
                    size: 25,
                  ),
                )
              : null,
          suffixIcon: suffixIconData != null
              ? GestureDetector(
                  onTap: suffixOnTap,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Icon(
                      suffixIconData,
                      color: suffixIconColor,
                      size: 25,
                    ),
                  ),
                )
              : null,
        ),
        validator: validator,
      ),
    );
  }
}
