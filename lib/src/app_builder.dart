import 'package:flutter/material.dart';
import 'package:maali/src/app_controller.dart';

/// An abstract interface for creating parts of an application indepedent of
/// the assembly process.
abstract class AppBuilder {}

/// AppBuilder responsible for defining the Application Styling and Theme.
class AppStyler extends AppBuilder {
  static const lightMode = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFbdbdbd),
      onPrimary: Color(0xFF735761),
      primaryContainer: Color(0xFFbdbdbd),
      onPrimaryContainer: Color(0xFF383838),
      secondary: Color(0xFF735761),
      onSecondary: Color(0xFF735761),
      secondaryContainer: Color(0xff242424),
      onSecondaryContainer: Color(0xFFFFD8E6),
      tertiary: Color(0xFF735761),
      onTertiary: Color(0xFF735761),
      tertiaryContainer: Color(0xff242424),
      onTertiaryContainer: Color(0xFFFFD8E6),
      error: Color(0xFF735761),
      onError: Color(0xFF735761),
      background: Color(0xFFdbdbdb), // main
      onBackground: Color(0xFF735761),
      surface: Color(0xFFf0f0f0), // lighter shade background
      onSurface: Color(0xFF383838)); // default text

  static const darkMode = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF949494),
      onPrimary: Color(0xFFF0F0F0),
      primaryContainer: Color(0xff242424),
      onPrimaryContainer: Color(0xFF383838),
      secondary: Color(0xFFE1BDCA),
      onSecondary: Color(0xFFF0F0F0),
      secondaryContainer: Color(0xff242424),
      onSecondaryContainer: Color(0xFFFFD8E6),
      tertiary: Color(0xFF735761),
      onTertiary: Color(0xFF735761),
      tertiaryContainer: Color(0xff242424),
      onTertiaryContainer: Color(0xFFFFD8E6),
      error: Color(0xFF735761),
      onError: Color(0xFF735761),
      background: Color(0xFF050505), // main background
      onBackground: Color(0xFFF0F0F0),
      surface: Color(0xFF424242),
      onSurface: Color(0xFFF0F0F0)); // default text

  static TextStyle headerStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontSize: 14,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w400,
      letterSpacing: 3,
    );
  }

  static ButtonStyle appButton(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(
          Theme.of(context).colorScheme.primary),
      foregroundColor: MaterialStatePropertyAll<Color>(
          Theme.of(context).colorScheme.onPrimary),
    );
  }

  static Text appTitle(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.appTitle,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 25,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w400,
        letterSpacing: 3,
      ),
    );
  }

  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      // colorScheme: Theme.of(context).colorScheme,
      primarySwatch: Colors.blueGrey,
      primaryColor: Theme.of(context).colorScheme.surface,
      indicatorColor: const Color(0xffCBDCF8),
      hintColor: const Color(0xff4285F4),
      highlightColor: const Color(0xffFCE192),
      hoverColor: const Color(0xff4285F4),
      focusColor: const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: Theme.of(context).colorScheme.primary,
      canvasColor: Theme.of(context).colorScheme.surface,
      brightness: Brightness.light,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}

/// A Layout Builder for supporting a responsive UI.
///
/// Centralises the use of [MediaQuery].
class AppFlexer extends AppBuilder {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 800;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 800 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  // static Widget FlexLayout(BuildContext context) {
  //   final Widget largeScreen;
  //   final Widget? mediumScreen;
  //   final Widget? smallScreen;

  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       if (constraints.maxWidth > 1200) {
  //         return largeScreen;
  //       } else if (constraints.maxWidth <= 1200 &&
  //           constraints.maxWidth >= 800) {
  //         return mediumScreen ?? largeScreen;
  //       } else {
  //         return smallScreen ?? largeScreen;
  //       }
  //     },
  //   );
  // }
}

class Insets extends AppBuilder {
  static double medium = 5;
  static double large = 10;
  static double extraLarge = 20;
  static double small = 3;
}
