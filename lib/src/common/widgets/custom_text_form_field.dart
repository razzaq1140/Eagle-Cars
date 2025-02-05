import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final int? maxLines;
  final int? maxLength;
  final double? height;
  final double? hintFontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final EdgeInsetsGeometry? contentPadding;
  final String? hint;
  final String? labelText;
  final String? initialValue;
  final bool? obscureText;
  final bool filled;
  final bool? isCollapsed;
  final bool? isDense;
  final bool? isEnabled;
  final bool? readOnly;
  final Color? fillColor;
  final Color? hintColor;
  final Color? inputColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final InputDecoration? customDecoration;
  final String? semanticLabel;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? helperText; // New parameter for helper text

  const CustomTextFormField({
    super.key,
    this.maxLines,
    this.maxLength,
    this.height,
    this.hintFontSize,
    this.fontWeight,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.contentPadding,
    this.hint,
    this.labelText,
    this.initialValue,
    this.obscureText,
    this.filled = true,
    this.isCollapsed,
    this.isDense,
    this.isEnabled,
    this.readOnly,
    this.fillColor,
    this.hintColor,
    this.inputColor,
    this.borderColor,
    this.focusBorderColor,
    this.cursorColor,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.autoValidateMode,
    this.textStyle,
    this.errorTextStyle,
    this.customDecoration,
    this.semanticLabel,
    this.autofillHints,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.validator,
    this.controller,
    this.helperText, // Initialize helper text
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4, // Higher elevation for prominent shadow
      shadowColor: Colors.grey.withOpacity(0.5), // Shadow color and opacity
      borderRadius:
          BorderRadius.circular(8), // Optional: to give rounded corners
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        obscureText: obscureText ?? false,
        cursorColor: cursorColor,
        maxLines: (obscureText ?? false)
            ? 1
            : (maxLines ?? 1), // Ensure obscureText is single line
        textInputAction: textInputAction,
        initialValue: initialValue,
        style: textStyle,
        autofocus: false,
        keyboardType: keyboardType,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        autovalidateMode:
            autoValidateMode ?? AutovalidateMode.onUserInteraction,
        readOnly: readOnly ?? false,
        enabled: isEnabled ?? true,
        decoration: customDecoration ??
            InputDecoration(
              labelText: labelText,
              counterText: '',
              hintText: hint,
              hintStyle: TextStyle(
                  color: hintColor ?? Theme.of(context).colorScheme.onSurface,
                  fontSize: hintFontSize ?? 13),
              filled: filled,
              fillColor: fillColor ?? Theme.of(context).colorScheme.surface,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              prefixIconConstraints: prefixIconConstraints,
              suffixIconConstraints: suffixIconConstraints,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: horizontalPadding ?? 20.0,
                    vertical: verticalPadding ?? 10,
                  ),
              errorStyle: errorTextStyle,
              errorMaxLines: 2,
              isCollapsed: isCollapsed ?? false,
              isDense: isDense,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: focusBorderColor ?? Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
            ),
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        onTapOutside: onTapOutside ??
            (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
      ),
    );
  }
}
