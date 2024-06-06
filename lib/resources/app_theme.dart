import 'package:flutter/material.dart';

import 'color_pallete.dart';

// Defined for custom theme template
class AppTheme {
  // Light theme for light mode brightness
  static ThemeData get lightTheme {
    // Initialize base theme first such as colors
    final ThemeData base = ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: ColorPalette.primarySwatch,
        // backgroundColor: Colors.white,
        // cardColor: Colors.white,
      ),
      // primaryColor: ColorPalette.primaryColor,
      primaryColor: ColorPalette.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      dividerColor: Colors.black.withOpacity(0.5),
      unselectedWidgetColor: Colors.black.withOpacity(0.5),
      // canvasColor: Colors.white,
    );

    // Combine with common theme data then return
    return _buildThemeData(base);
  }

  // Build common theme data for all brightness
  static ThemeData _buildThemeData(ThemeData base) {
    // Build text theme first to prevent from different text theme on `Text` widget with all `Input Decoration`
    final textTheme = _buildTextTheme(base);
    return ThemeData(
      canvasColor: Colors.white,
      brightness: base.brightness,
      colorScheme: base.colorScheme,
      textTheme: textTheme,
      appBarTheme: _buildAppBarTheme(base),
      tabBarTheme: _buildTabbarTheme(base),
      iconTheme: _buildIconThemeData(base),
      inputDecorationTheme:
          _buildInputDecorationTheme(base.copyWith(textTheme: textTheme)),
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(base),
      outlinedButtonTheme: _buildOutlinedButtonThemeData(base),
      elevatedButtonTheme: _buildElevatedButtonThemeData(base),
      dividerTheme: _buildDividerTheme(base),
      checkboxTheme: _buildCheckboxThemeData(base),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: true,
        selectedItemColor: base.colorScheme.primary,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      chipTheme: ChipThemeData(
        selectedColor: base.colorScheme.primary,
        backgroundColor: base.colorScheme.background,
        elevation: 0,
        pressElevation: 0,
      ),
      primaryColor: base.primaryColor,
      scaffoldBackgroundColor: base.scaffoldBackgroundColor,
      dividerColor: base.dividerColor,
      unselectedWidgetColor: base.unselectedWidgetColor,
      shadowColor: base.shadowColor,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return ColorPalette.primaryColor;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return ColorPalette.primaryColor;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return ColorPalette.primaryColor;
          }
          return null;
        }),
      ),
    );
  }

  static CheckboxThemeData _buildCheckboxThemeData(ThemeData base) {
    return CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(base.colorScheme.primary),
      checkColor: MaterialStateProperty.all<Color>(base.colorScheme.background),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: BorderSide(color: base.colorScheme.outline),
    );
  }

  static AppBarTheme _buildAppBarTheme(ThemeData theme) {
    return AppBarTheme(
      centerTitle: false,
      color: theme.colorScheme.primary,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: theme.colorScheme.onBackground,
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: theme.iconTheme.copyWith(
        color: theme.colorScheme.onBackground,
      ),
    );
  }

  static TabBarTheme _buildTabbarTheme(ThemeData theme) => TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: theme.colorScheme.primary, width: 2))),
        labelColor: theme.colorScheme.primary,
      );

  static FloatingActionButtonThemeData _buildFloatingActionButtonTheme(
          ThemeData theme) =>
      theme.floatingActionButtonTheme
          .copyWith(backgroundColor: theme.primaryColor);

  static InputDecorationTheme _buildInputDecorationTheme(ThemeData theme) =>
      InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 10.0,
        ),
        hintStyle: theme.textTheme.bodyMedium!.copyWith(
          color: theme.brightness == Brightness.light
              ? Colors.black.withOpacity(0.25)
              : theme.primaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
      );

  static OutlinedButtonThemeData _buildOutlinedButtonThemeData(
          ThemeData theme) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(8.0),
          foregroundColor: theme.primaryColor,
          side: const BorderSide(color: ColorPalette.primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );

  static ElevatedButtonThemeData _buildElevatedButtonThemeData(
          ThemeData theme) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8.0),
          foregroundColor: theme.colorScheme.onSecondary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );

  static IconThemeData _buildIconThemeData(ThemeData theme) =>
      theme.iconTheme.copyWith(
        color: theme.brightness == Brightness.light
            ? Colors.black
            : theme.primaryColor,
      );

  static TextTheme _buildTextTheme(ThemeData base) {
    var textTheme = base.textTheme;
    return base.textTheme
        .copyWith(
            displayLarge: textTheme.displayLarge!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 57.0,
            ),
            displayMedium: textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 45.0,
            ),
            displaySmall: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 36.0,
            ),
            headlineLarge: textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 32.0,
            ),
            headlineMedium: textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 28.0,
            ),
            headlineSmall: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
            ),
            titleLarge: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 22.0,
            ),
            titleMedium: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
            titleSmall: textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
            labelMedium: textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
            bodyLarge: textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
            bodyMedium: textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
            bodySmall: textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
            labelLarge: textTheme.labelLarge!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            labelSmall: textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ))
        .apply(
          fontFamily: 'Inter',
          displayColor: Colors.black,
          bodyColor: Colors.black,
        );
  }

  static DividerThemeData _buildDividerTheme(ThemeData base) =>
      base.dividerTheme.copyWith(
        color: base.dividerColor,
        thickness: 1,
      );
}
