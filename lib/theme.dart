import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:safa_app/gen/colors.gen.dart';

ThemeData customTheme() {
  // TODO(mine2424): テーマ切り替える.
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: AppColor.primaryGreen,
    cardColor: Colors.white,
    scaffoldBackgroundColor: AppColor.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColor.primaryGreen,
      selectionColor: AppColor.primaryGreen,
      selectionHandleColor: AppColor.primaryGreenDark,
    ),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColor.white,
        side: const BorderSide(
          color: AppColor.primaryOrange,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColor.primaryOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColor.primaryOrange,
        textStyle: const TextStyle(color: AppColor.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

TextTheme _buildTextTheme(TextTheme textTheme) {
  // return GoogleFonts.notoSansJpTextTheme()
  return GoogleFonts.notoSansJpTextTheme()
      .apply(
        displayColor: AppColor.black,
        bodyColor: AppColor.black,
      )
      .merge(
        textTheme.copyWith(
          displayLarge: textTheme.displayLarge!.copyWith(
            color: AppColor.black,
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: textTheme.displayMedium!.copyWith(
            color: AppColor.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: textTheme.displaySmall!.copyWith(
            color: AppColor.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: textTheme.headlineLarge!.copyWith(
            color: AppColor.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: textTheme.headlineMedium!.copyWith(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: textTheme.headlineSmall!.copyWith(
            color: AppColor.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: textTheme.bodyLarge!.copyWith(
            color: AppColor.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: textTheme.bodyMedium!.copyWith(
            color: AppColor.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: textTheme.bodySmall!.copyWith(
            color: AppColor.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          labelLarge: textTheme.labelLarge!.copyWith(
            color: AppColor.black,
            fontSize: 16,
            fontWeight: FontWeight.w200,
          ),
          labelMedium: textTheme.labelMedium!.copyWith(
            color: AppColor.black,
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
          labelSmall: textTheme.labelSmall!.copyWith(
            color: AppColor.black,
            fontSize: 12,
            fontWeight: FontWeight.w200,
          ),
        ),
      );
}

TextStyle boldNotoSansTextStyle(int fontSize, {Color? color}) {
  return GoogleFonts.notoSansJp(
    color: color ?? AppColor.black,
    fontSize: fontSize.toDouble(),
    fontWeight: FontWeight.bold,
  );
}
