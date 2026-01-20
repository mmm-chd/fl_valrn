import 'package:fl_valrn/configs/themes_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final Color? fillColor, borderColor;
  final bool isNumber;
  final String label, hint;
  final double? marginTop;
  final TextEditingController controller;
  final bool? obscureText,
      readOnly,
      enableSuggestion,
      isShow,
      enableInteractiveSelection,
      useSuffixIcon,
      usePrefixIcon;
  final GestureTapCallback? onTap, onTapSuffixIcon, onTapPrefixIcon;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon, prefixIcon;
  final FocusNode? focusNode;
  final bool borderless;
  final TextFieldVariant variant;

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
    this.onTapSuffixIcon,
    this.onTapPrefixIcon,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.onChanged,
    this.useSuffixIcon = false,
    this.usePrefixIcon = false,
    this.fillColor,
    this.borderColor,
    this.borderless= false,
    this.variant = TextFieldVariant.outline,
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
        // decoration: InputDecoration(
        //   fillColor: fillColor,
        //   filled: borderless ? false : true,
        //   labelStyle: TextStyle(color: Colors.grey.shade700),
        //   hintStyle: TextStyle(color: SColor.secGrey.withValues(alpha: 0.7)),
        //   labelText: label,
        //   alignLabelWithHint: false,
        //   hintText: hint,
        //   floatingLabelBehavior: FloatingLabelBehavior.never,
        //   hintFadeDuration: Duration(milliseconds: 500),

        //   border: borderless ? InputBorder.none : OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(12.0),
        //     borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400),
        //   ),

        //   errorBorder: borderless ? InputBorder.none : OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(12.0),
        //     borderSide: BorderSide(color:Colors.red),
        //   ),

        //   focusedErrorBorder: borderless ? InputBorder.none : OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(12.0),
        //     borderSide: BorderSide(color: Colors.red),
        //   ),

        //   focusedBorder: borderless ? InputBorder.none : OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(12.0),
        //     borderSide: BorderSide(color: PColor.primGreen),
        //   ),

        //   enabledBorder: borderless ? InputBorder.none : OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(12.0),
        //     borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400),
        //   ),

        //   disabledBorder: borderless ? InputBorder.none : OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(12.0),
        //     borderSide: BorderSide(color: Colors.grey.shade200),
        //   ),
         
        //   prefixIcon: usePrefixIcon!
        //       ? GestureDetector(onTap: onTapPrefixIcon, child: prefixIcon)
        //       : null,
        //   suffixIcon: useSuffixIcon!
        //       ? GestureDetector(onTap: onTapSuffixIcon, child: suffixIcon)
        //       : null,
        //   contentPadding: borderless
        //       ? const EdgeInsets.symmetric(horizontal: 0, vertical: 12)
        //       : const EdgeInsets.all(16),
        // ),
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: borderless ? false : true,
          labelStyle: TextStyle(color: Colors.grey.shade700),
          hintStyle: TextStyle(color: SColor.secGrey.withValues(alpha: 0.7)),
          labelText: label,
          alignLabelWithHint: false,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintFadeDuration: Duration(milliseconds: 500),


          border: _buildBorder(borderColor ?? Colors.grey.shade400),
          enabledBorder: _buildBorder(borderColor ?? Colors.grey.shade400),
          focusedBorder: _buildBorder(PColor.primGreen),
          errorBorder: _buildBorder(Colors.red),
          focusedErrorBorder: _buildBorder(Colors.red),

          contentPadding: variant == TextFieldVariant.underline
              ? const EdgeInsets.symmetric(vertical: 12)
              : const EdgeInsets.all(16),

          prefixIcon: usePrefixIcon!
              ? GestureDetector(onTap: onTapPrefixIcon, child: prefixIcon)
              : null,

          suffixIcon: useSuffixIcon!
              ? GestureDetector(onTap: onTapSuffixIcon, child: suffixIcon)
              : null,
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
  InputBorder _buildBorder(Color color){
        switch (variant) {
          case TextFieldVariant.underline:
            return UnderlineInputBorder(
              borderSide: BorderSide(color: color, width: 1),
            );
          case TextFieldVariant.borderless:
            return InputBorder.none;
          case TextFieldVariant.outline:
          default:
            return OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: color)
            );
        }
      }
}

enum TextFieldVariant {
  outline,
  underline,
  borderless
}
