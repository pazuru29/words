import 'dart:ui';

class AppTextStyles {
  static const AppStyle headerLarge = AppStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
  );

  static const AppStyle headerMedium = AppStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const AppStyle headerSmall = AppStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
  );

  static const AppStyle regular12 = AppStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const AppStyle regular14 = AppStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const AppStyle regular16 = AppStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const AppStyle regular20 = AppStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const AppStyle semibold14 = AppStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const AppStyle semibold16 = AppStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const AppStyle semibold18 = AppStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}

class AppStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final String fontFamily;
  final double letterSpacing;

  const AppStyle({
    required this.fontSize,
    required this.fontWeight,
    this.fontStyle = FontStyle.normal,
    this.fontFamily = 'Roboto',
    this.letterSpacing = 0,
  });
}
