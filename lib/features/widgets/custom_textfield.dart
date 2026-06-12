import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jo_news/core/styles/app_colors.dart';
import 'package:jo_news/core/styles/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.width,
    this.maxLines,
    this.keyboardType,
    this.textColor,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.onSubmitted,
    this.onChanged,
    this.isPassword = false,
    this.autofocus = false,
  });

  final TextEditingController? controller;

  final String? hintText;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final double? width;
  final int? maxLines;
  final double? borderRadius;
  final double? contentPadding;

  final Color? textColor;
  final Color? fillColor;
  final Color? borderColor;

  final TextInputType? keyboardType;

  final bool isPassword;
  final bool autofocus;

  final Function(String)? onSubmitted;
  final Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: widget.width ?? double.infinity,

      child: TextField(
        controller: widget.controller,

        maxLines: widget.isPassword ? 1 : widget.maxLines ?? 1,

        keyboardType: widget.keyboardType ?? TextInputType.text,

        obscureText: widget.isPassword ? isObscure : false,

        autofocus: widget.autofocus,

        cursorColor: AppColors.primaryColor,

        onSubmitted: widget.onSubmitted,

        onChanged: widget.onChanged,

        style:
            Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16.sp,
              color: widget.textColor ?? colorScheme.onSurface,
            ) ??
            TextStyle(
              fontSize: 16.sp,
              color: widget.textColor ?? colorScheme.onSurface,
            ),

        decoration: InputDecoration(
          hintText: widget.hintText,

          hintStyle: AppTextStyles.merriweatherRegular16,

          filled: true,

          fillColor: widget.fillColor ?? colorScheme.surfaceContainerHighest,

          prefixIcon: widget.prefixIcon,

          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : widget.suffixIcon,

          contentPadding: EdgeInsets.symmetric(
            horizontal: widget.contentPadding ?? 18.w,
            vertical: widget.contentPadding ?? 18.h,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
            borderSide: BorderSide(
              color:
                  widget.borderColor ??
                  AppColors.primaryColor.withValues(alpha: 0.3),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
            borderSide: BorderSide(
              color:
                  widget.borderColor ??
                  AppColors.primaryColor.withValues(alpha: 0.7),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
