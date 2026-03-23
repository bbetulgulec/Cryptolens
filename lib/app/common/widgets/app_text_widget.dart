import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextDecoration? decoration;

  const AppTextWidget._(
    this.text, {
    super.key,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.decoration,
  });

  factory AppTextWidget.bold(
    String text, {
    Key? key,
    double? size,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) {
    return AppTextWidget._(
      text,
      key: key,
      fontSize: size ?? 24,
      fontWeight: fontWeight,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      decoration: decoration,
    );
  }
  factory AppTextWidget.big(
    String text, {
    Key? key,
    double? size,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) {
    return AppTextWidget._(
      text,
      key: key,
      fontSize: size ?? 34,
      fontWeight: fontWeight,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      decoration: decoration,
    );
  }

  factory AppTextWidget.semiBold(
    String text, {
    Key? key,
    double? size,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) {
    return AppTextWidget._(
      text,
      key: key,
      fontSize: size ?? 18,
      fontWeight: fontWeight,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      decoration: decoration,
    );
  }

  factory AppTextWidget.medium(
    String text, {
    Key? key,
    double? size,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) {
    return AppTextWidget._(
      text,
      key: key,
      fontSize: size ?? 16,
      fontWeight: fontWeight,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      decoration: decoration,
    );
  }

  factory AppTextWidget.regular(
    String text, {
    Key? key,
    double? size,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
  }) {
    return AppTextWidget._(
      text,
      key: key,
      fontSize: size ?? 14,
      fontWeight: fontWeight,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      decoration: decoration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        decoration: decoration,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
