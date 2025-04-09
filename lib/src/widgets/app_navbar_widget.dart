import 'package:flutter/material.dart';

import 'package:maali/src/app_builder.dart';
import 'package:maali/src/app_controller.dart';
import 'package:maali/src/app_router.dart';
import 'package:maali/src/app_security.dart';

/// Special Application Widget for adding a [BottomNavigationBar].
///
/// This widget is always built with the [ViewsRouterDelegate] to manage any
/// operations outside the application (ie back button). A [BottomNavigationBar]
/// also falls under this category as this framework is built with Flutters
/// Navigator 2.0 path routing.
class AppNavbarWidget extends StatefulWidget {
  const AppNavbarWidget({Key? appNavbarKey, required this.appController})
      : super(key: appNavbarKey);

  final AppController appController;

  // The framework calls createState the first time a widget appears at a given
  // location in the tree. If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses the State object instead
  // of creating a new State object.
  @override
  State<AppNavbarWidget> createState() => _AppNavbarWidgetState();
}

class _AppNavbarWidgetState extends State<AppNavbarWidget> {
  late InnerRouterDelegate _routerDelegate;
  late ChildBackButtonDispatcher _backButtonDispatcher;

  @override
  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appController);
  }

  @override
  void didUpdateWidget(covariant AppNavbarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // widget.appController.appUser.permissions.credentials.first;

    // _routerDelegate.controller.routerIndex = widget.appController.routerIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher!
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    // var appState = widget.appState;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Scaffold(
        body: Router(
          routerDelegate: _routerDelegate,
          backButtonDispatcher: _backButtonDispatcher,
        ),
        bottomNavigationBar:
            widget.appController.accessManager.aMode == AppMode.mobile &&
                    !widget.appController.usingBackButton
                ? BottomNavigationBar(
                    backgroundColor:
                        widget.appController.themeMode == ThemeMode.light
                            ? AppStyler.themeData(context)
                                .primaryColorLight
                                .withOpacity(1)
                            : widget.appController.themeMode == ThemeMode.dark
                                ? ThemeData.dark().primaryColorDark
                                : ThemeData.light().primaryColorDark,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.my_library_books_outlined),
                          label: 'Samples'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.app_settings_alt_outlined),
                          label: 'Settings'),
                    ],
                    currentIndex: widget.appController.routerIndex,
                    onTap: (newIndex) {
                      widget.appController.routerIndex = newIndex;
                    })
                : null);
  }
}
