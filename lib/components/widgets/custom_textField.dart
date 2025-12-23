import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final Color? fillColor;
  final bool isNumber;
  final String label, hint;
  final double? marginTop;
  final TextEditingController controller;
  final bool? obscureText,
      readOnly,
      enableSuggestion,
      isShow,
      enableInteractiveSelection,
      useSuffixIcon;
  final GestureTapCallback? onTap, onTapIcon;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final FocusNode? focusNode;

  const CustomTextfield({
    super.key,
    required this.isNumber,
    this.label = "",
    this.hint = "",
    this.marginTop,
    required this.controller,
    this.obscureText,
    this.readOnly,
    this.enableSuggestion,
    this.isShow,
    this.enableInteractiveSelection,
    this.onTap,
    this.onTapIcon,
    this.suffixIcon,
    this.focusNode,
    this.onChanged,
    this.useSuffixIcon = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? 0.0),
      child: TextFormField(
        focusNode: focusNode,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumber
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        controller: controller,
        decoration: InputDecoration(
          fillColor: fillColor,
          labelText: label,
          alignLabelWithHint: false,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade100),
          labelStyle: TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintFadeDuration: Duration(milliseconds: 500),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          suffixIcon: useSuffixIcon!
              ? GestureDetector(onTap: onTapIcon, child: suffixIcon)
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.green),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
          contentPadding: EdgeInsets.all(8),
        ),
        enableInteractiveSelection: enableInteractiveSelection ?? true,
        enableSuggestions: enableSuggestion ?? false,
        obscureText: obscureText ?? false,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
