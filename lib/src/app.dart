import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:maali/src/app_builder.dart';
import 'package:maali/src/app_controller.dart';
import 'package:maali/src/app_router.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appController,
  });

  final AppController appController;

  @override
  Widget build(BuildContext context) {
    ViewsRouterDelegate vDelegate = ViewsRouterDelegate(appController);
    ViewsRouteInformationParser vInfoParser = ViewsRouteInformationParser();

    // Glue the Controller and Router to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the AppController and Router
    // delegate for any changes. The MaterialApp is rebuilt with user updates.
    return AnimatedBuilder(
      animation: appController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: appController.themeMode == ThemeMode.system
              ? AppStyler.themeData(context)
              : ThemeData(useMaterial3: true, colorScheme: AppStyler.lightMode),
          darkTheme:
              ThemeData(useMaterial3: true, colorScheme: AppStyler.darkMode),
          themeMode: appController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          routerDelegate: vDelegate,
          routeInformationParser: vInfoParser,
        );
      },
    );
  }
}
