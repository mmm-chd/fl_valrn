import 'package:fl_valrn/configs/themes_color.dart';
import 'package:fl_valrn/formatter/dateInput_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final Color? fillColor, borderColor;
  final bool isNumber, isDate;
  final String label, hint;
  final String? helperText, errorText, suffixText, prefixText;
  final double? marginTop;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final bool? obscureText,
      readOnly,
      enableSuggestion,
      isShow,
      enableInteractiveSelection,
      useSuffixIcon,
      usePrefixIcon,
      filled,
      isError;
  final GestureTapCallback? onTap, onTapSuffixIcon, onTapPrefixIcon;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon, prefixIcon;
  final FocusNode? focusNode;
  final TextStyle? helperStyle, errorStyle, suffixStyle, prefixStyle;
  final int? helperMaxLines, errorMaxLines;

  const CustomTextfield({
    super.key,
    this.isNumber = false,
    this.isDate = false,
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
    this.filled,
    this.isError,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.validator,
    this.suffixText,
    this.suffixStyle,
    this.textInputType,
    this.prefixText,
    this.prefixStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? 0.0),
      child: TextFormField(
        focusNode: focusNode,
        keyboardType:
            textInputType ??
            (isDate
                ? TextInputType.number
                : (isNumber ? TextInputType.number : TextInputType.text)),
        inputFormatters: isDate
            ? [DateinputFormatter()]
            : isNumber
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        controller: controller,
        decoration: InputDecoration(
          filled: filled ?? false,
          fillColor: fillColor,
          labelStyle: TextStyle(color: Colors.grey.shade700),
          hintStyle: TextStyle(color: SColor.secGrey.withValues(alpha: 0.7)),
          labelText: label,
          alignLabelWithHint: false,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintFadeDuration: Duration(milliseconds: 500),
          prefixText: prefixText,
          prefixStyle:
              suffixStyle ??
              TextStyle(
                fontSize: 16,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w600,
              ),
          suffixText: suffixText,
          suffixStyle:
              suffixStyle ??
              TextStyle(
                fontSize: 16,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w600,
              ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.red),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.red),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: PColor.primGreen),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: borderColor ?? Colors.grey.shade300),
          ),

          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),

          helperText: helperText,
          helperStyle:
              helperStyle ??
              TextStyle(color: Colors.grey.shade200, fontSize: 14, height: 1.4),
          helperMaxLines: helperMaxLines ?? 2,

          errorText: errorText,
          errorStyle:
              errorStyle ??
              TextStyle(color: Colors.red, fontSize: 14, height: 1.4),
          errorMaxLines: errorMaxLines ?? 2,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: borderColor ?? Colors.grey.shade400),
          ),

          prefixIcon: usePrefixIcon!
              ? GestureDetector(onTap: onTapPrefixIcon, child: prefixIcon)
              : null,
              
          suffixIcon: useSuffixIcon!
              ? GestureDetector(onTap: onTapSuffixIcon, child: suffixIcon)
              : null,
          contentPadding: EdgeInsets.all(12),
        ),
        enableInteractiveSelection: enableInteractiveSelection ?? true,
        enableSuggestions: enableSuggestion ?? false,
        obscureText: obscureText ?? false,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        onTap: onTap,
        validator: validator,
      ),
    );
  }
}
