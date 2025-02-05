import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/global_variable.dart';

// class CustomElevatedButton extends StatelessWidget {
//   final Function() onPressed;
//   final String text;
//   final double? textSize;
//   final double? borderRadius;
//   final double? elevation;
//   final Color? textColor;
//   final FontWeight? fontWeight;
//   final List<Color>? gradientColors;
//   final Color? color;
//   final EdgeInsetsGeometry? padding;
//   final double? width;
//   final double? height;
//   final IconData? icon;
//   final double? iconSize;
//   final Color? iconColor;
//   final bool isIconRight;

//   const CustomElevatedButton({
//     super.key,
//     required this.onPressed,
//     required this.text,
//     this.elevation,
//     this.textColor,
//     this.fontWeight,
//     this.textSize,
//     this.borderRadius,
//     this.gradientColors,
//     this.color,
//     this.padding,
//     this.width,
//     this.height,
//     this.icon,
//     this.iconSize,
//     this.iconColor,
//     this.isIconRight = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         minimumSize: Size.fromHeight(height ?? 56),
//         padding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius ?? 8),
//         ),
//         elevation: elevation ?? 0,
//       ),
//       child: Ink(
//         decoration: BoxDecoration(
//           color: color ??
//               Theme.of(context)
//                   .colorScheme
//                   .primary, // Set button color to primary
//           gradient: null, // Disable gradient since color is provided
//           borderRadius: BorderRadius.circular(borderRadius ?? 8),
//         ),
//         child: Container(
//           width: width,
//           height: height,
//           alignment: Alignment.center,
//           padding: padding ??
//               const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
//           child: isIconRight
//               ? _buildTextWithIcon(context)
//               : _buildIconWithText(context),
//         ),
//       ),
//     );
//   }

//   Widget _buildIconWithText(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (icon != null) ...[
//           Icon(
//             icon,
//             size: iconSize ?? 20,
//             color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
//           ),
//           const SizedBox(width: 8),
//         ],
//         Text(
//           text,
//           style: GoogleFonts.dmSans(
//               color: textColor ?? colorScheme(context).onPrimary,
//               fontWeight: fontWeight ?? FontWeight.w600,
//               fontSize: textSize ?? 16,
//               letterSpacing: 0.5),
//         ),
//       ],
//     );
//   }

//   Widget _buildTextWithIcon(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           text,
//           style: GoogleFonts.roboto(
//               color: textColor ?? colorScheme(context).onPrimary,
//               fontWeight: fontWeight ?? FontWeight.w700,
//               fontSize: textSize ?? 16,
//               letterSpacing: 0.5),
//         ),
//         if (icon != null) ...[
//           const SizedBox(width: 8),
//           Icon(
//             icon,
//             size: iconSize ?? 20,
//             color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
//           ),
//         ],
//       ],
//     );
//   }
// }

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? textSize;
  final double? letterSpacing;
  final double? borderRadius;
  final double? elevation;
  final Color? textColor;
  final FontWeight? fontWeight;
  final List<Color>? gradientColors;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double? buttonHeight;
  final double? buttonWidth;
  final bool hasBorder;
  final Color? borderColor;
  final bool isLoading;
  final Widget? loadingIndicator;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.elevation,
    this.textColor,
    this.fontWeight,
    this.textSize,
    this.letterSpacing,
    this.borderRadius,
    this.gradientColors,
    this.backgroundColor,
    this.padding,
    this.width,
    this.height,
    this.buttonHeight,
    this.buttonWidth,
    this.hasBorder = false,
    this.borderColor,
    this.isLoading = false,
    this.loadingIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? 50,
      width: buttonWidth ?? double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            side: hasBorder
                ? BorderSide(
                    color: borderColor ?? Theme.of(context).colorScheme.primary,
                  )
                : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
          ),
          elevation: elevation ?? 0,
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
          ),
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    height: (buttonHeight ?? 50) * 0.6,
                    child: loadingIndicator ??
                        CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  )
                : Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        color: textColor ?? colorScheme(context).onPrimary,
                        fontWeight: fontWeight ?? FontWeight.w700,
                        fontSize: textSize ?? 16,
                        letterSpacing: 0.5),
                  ),
          ),
        ),
      ),
    );
  }
}
