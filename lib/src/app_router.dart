import 'package:flutter/material.dart';

import 'package:maali/src/app_controller.dart';
import 'package:maali/src/app_router.dart';
import 'package:maali/src/views/admin_view.dart';
import 'package:maali/src/widgets/app_navbar_widget.dart';

export 'package:maali/src/views/settings_view.dart';
export 'package:maali/src/views/landing_view.dart';
export 'package:maali/src/views/sample_item_view.dart';

// Available Route Paths
mixin AppRouter {}

// 0
class LandingViewPath with AppRouter {
  static const pathIndex = LandingView.viewIndex;
  static const path = '/home';
}

// 1
class SampleItemListViewPath with AppRouter {
  static const pathIndex = SampleItemListView.viewIndex;
  static const path = '/sample_list';
}

// 2
class SettingsViewPath with AppRouter {
  static const pathIndex = SettingsView.viewIndex;
  static const path = '/settings';
}

// 3
class AdminViewPath with AppRouter {
  static const pathIndex = AdminView.viewIndex;
  static const path = '/admin';
}

class ViewsRouteInformationParser extends RouteInformationParser<AppRouter> {
  @override
  Future<AppRouter> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location.toString());

    if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == LandingView.viewName) {
      return LandingViewPath();
    }
    if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == SettingsView.viewName) {
      return SettingsViewPath();
    }
    if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == SampleItemListView.viewName) {
      return SampleItemListViewPath();
    }
    if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == AdminView.viewName) {
      return AdminViewPath();
    }

    return landing.routePath;
  }

  @override
  RouteInformation restoreRouteInformation(AppRouter configuration) {
    if (configuration is LandingViewPath) {
      return const RouteInformation(location: LandingViewPath.path);
    }
    if (configuration is SettingsViewPath) {
      return const RouteInformation(location: SettingsViewPath.path);
    }
    if (configuration is SampleItemListViewPath) {
      return const RouteInformation(location: SampleItemListViewPath.path);
    }
    return const RouteInformation(location: '/404');
  }
}

class InitIndex {
  List<AppRouter> paths = [
    LandingViewPath(),
    SampleItemListViewPath(),
    SettingsViewPath(),
    AdminViewPath(),
  ];

  final int idx;

  InitIndex(this.idx);

  AppRouter get routePath => paths[idx];
}

late InitIndex landing;

class ViewsRouterDelegate extends RouterDelegate<AppRouter>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouter> {
  // ignore: annotate_overrides
  final GlobalKey<NavigatorState> navigatorKey;

  AppController appController;

  // ViewsAppState appState = ViewsAppState();

  ViewsRouterDelegate(this.appController)
      : navigatorKey = GlobalKey<NavigatorState>() {
    appController.addListener(notifyListeners);
    landing = InitIndex(appController.appUser.permissions.credentials.first);
  }

  @override
  AppRouter get currentConfiguration {
    if (appController.routerIndex == LandingViewPath.pathIndex) {
      return LandingViewPath();
    }
    if (appController.routerIndex == SettingsViewPath.pathIndex) {
      return SettingsViewPath();
    }
    if (appController.routerIndex == SampleItemListViewPath.pathIndex) {
      return SampleItemListViewPath();
    }
    if (appController.routerIndex == AdminViewPath.pathIndex) {
      return AdminViewPath();
    }
    return SettingsViewPath();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: AppNavbarWidget(
            appController: appController,
          ),
        ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        notifyListeners();
        return true;
      },
    );
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> setNewRoutePath(AppRouter path) async {
    if (path is LandingViewPath) {
      appController.routerIndex = LandingViewPath.pathIndex;
    }
    if (path is SettingsViewPath) {
      appController.routerIndex = SettingsViewPath.pathIndex;
    }
    if (path is SampleItemListViewPath) {
      appController.routerIndex = SampleItemListViewPath.pathIndex;
    }
    if (path is AdminViewPath) {
      appController.routerIndex = AdminViewPath.pathIndex;
    }
  }
}

class InnerRouterDelegate extends RouterDelegate<AppRouter>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRouter> {
  InnerRouterDelegate(this._appController);

  @override
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final AppController _appController;
  // allow inner router controller to be available or external actions.
  AppController get controller => _appController;

  // set appState(ViewsAppState value) {
  //   if (value == _appState) {
  //     return;
  //   }
  //   _appState = value;
  //   notifyListeners();
  // }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (_appController.routerIndex == LandingView.viewIndex) ...[
          MaterialPage(
            key: ValueKey(_appController.routerIndex),
            child: LandingView(controller: _appController),
          ),
        ],
        if (_appController.routerIndex == SettingsView.viewIndex) ...[
          MaterialPage(
            key: ValueKey(_appController.routerIndex),
            child: SettingsView(controller: _appController),
          ),
        ],
        if (_appController.routerIndex == SampleItemListView.viewIndex) ...[
          MaterialPage(
            key: ValueKey(_appController.routerIndex),
            child: SampleItemListView(controller: _appController),
          ),
        ],
        if (_appController.routerIndex == AdminView.viewIndex) ...[
          MaterialPage(
            key: ValueKey(_appController.routerIndex),
            child: AdminView(controller: _appController),
          ),
        ],
      ],
      onPopPage: (route, result) {
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> setNewRoutePath(AppRouter path) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  // void _handleBookTapped(Book book) {
  //   appState.selectedBook = book;
  //   notifyListeners();
  // }
}
