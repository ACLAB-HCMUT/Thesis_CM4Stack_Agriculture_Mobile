//
// import 'package:flutter/material.dart';
//
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/sizes.dart';
//
// class RoundedContainer extends StatelessWidget {
//   const RoundedContainer({
//     super.key,
//     this.width,
//     this.height,
//     this.radius = TSizes.cardRadiusLg,
//     this.child,
//     this.showBorder = false,
//     this.padding,
//     this.margin,
//     this.borderColor = TColors.borderPrimary,
//     this.backgroundColor = TColors.white, required this.shadow,
//   });
//
//   final double? width, height;
//   final double radius;
//   final Widget? child;
//   final bool showBorder;
//   final EdgeInsetsGeometry? padding, margin;
//   final Color borderColor, backgroundColor;
//   final List<BoxShadow> shadow;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       margin: margin,
//       padding: padding,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(radius),
//         color: backgroundColor,
//         border: showBorder ? Border.all(color: borderColor) : null,
//         boxShadow: shadow,
//       ),
//       child: child,
//     );
//   }
// }
//
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = TSizes.cardRadiusHg,
    this.child,
    this.showBorder = false,
    this.padding,
    this.margin,
    this.borderColor = TColors.borderPrimary,
    this.backgroundColor = TColors.white,
    required this.shadow,
    this.gradient, // New gradient field
  });

  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final EdgeInsetsGeometry? padding, margin;
  final Color borderColor, backgroundColor;
  final List<BoxShadow> shadow;
  final Gradient? gradient; // Optional gradient field

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: gradient == null ? backgroundColor : null, // Use gradient if provided
        gradient: gradient, // Apply gradient if not null
        border: showBorder ? Border.all(color: borderColor) : null,
        boxShadow: shadow,
      ),
      child: child,
    );
  }
}
