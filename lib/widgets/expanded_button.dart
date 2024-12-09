import 'package:flutter/material.dart';
import 'package:capp_flutter/utils/base_imports.dart';

class ExpandedButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isDisable;
  final Color color;
  final double? height;
  final double? width;
  final TextStyle? labelStyle;
  final BorderRadius? borderRadius;
  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;

  // Normally this is not needed. However, when the button overlaps with other widgets,
  // it is needed to make the button opaque when it is disabled. So that behind the button,
  // other widgets are not visible. If null, button will remain transparent when disabled.
  final Color? disableStateOpaqueColor;

  const ExpandedButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isDisable = false,
    this.color = Colors.white,
    this.height,
    this.labelStyle,
    this.width,
    this.borderRadius,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.disableStateOpaqueColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisable ? null : onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 60.h,
        decoration: BoxDecoration(
          color: disableStateOpaqueColor ?? Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(16.r),
        ),
        child: Opacity(
          opacity: isDisable ? 0.5 : 1,
          child: Container(
            width: width ?? double.infinity,
            height: height ?? 60.h,
            decoration: decoration ??
                BoxDecoration(
                  color: color,
                  borderRadius: borderRadius ?? BorderRadius.circular(16.r),
                ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leftIcon != null) leftIcon!,
                Text(
                  label,
                  style: labelStyle,
                ),
                if (rightIcon != null) rightIcon!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
