import 'package:flutter/cupertino.dart';
import 'package:maali/src/app_router.dart';
import 'package:maali/src/views/admin_view.dart';

/// Components providing security operations that are necessary for supporting
/// multi-platform applications.
abstract class AppSecurity {}

enum AppMode { web, desktop, mobile }

/// Coordinates security related components and provides a central access point
/// for administering functionality during the application flow.
class SecureAppManager extends AppSecurity with ChangeNotifier {
  late SecureAccessController accessController;
  late SecureAppUser _authUser;
  AppMode aMode = AppMode.web;
  bool _isAuthorised = false;

  SecureAppManager(
    this.aMode,
  ) {
    accessController = SecureAccessController(aMode);
  }

  authorise(SecureAppUser u) {
    _authUser = u;
    accessController.authorise(_authUser);
    _isAuthorised =
        _authUser._permissions.credentials.length > 1 ? true : false;
    if (!_isAuthorised) {
      _authUser.id = DateTime.now().microsecondsSinceEpoch;
    }
    notifyListeners();
  }

  // user is registered.
  get auth => _isAuthorised;

  // user can save.
  get authToSave => auth && aMode.canSave ? true : false;
}

/// Represents an authenticated user with registered identity details,
/// permissions, authorised credential information.
class SecureAppUser extends AppSecurity {
  late int id;
  late String name;
  late String email;

  static final SecureAppUser anonymous = SecureAppUser(
      id: DateTime.now().millisecond, name: 'Guest', email: 'guest@company.au');

  SecureAppUser({
    required this.id,
    required this.name,
    required this.email,
  });

  late PermissionCollection _permissions;

  setPermissions(PermissionCollection p) => _permissions = p;
  PermissionCollection get permissions => _permissions;

  bool canAccess(int view) => _permissions.credentials.contains(view);

  factory SecureAppUser.fromJson(Map<String, dynamic> json) {
    return SecureAppUser(
      id: json['i'] as int,
      name: json['n'] as String,
      email: json['e'] as String,
    );
  }

  /// A function to convert the current object to a map for storing as JSON.
  Map<String, dynamic> toJson() => {
        "i": id,
        "n": name,
        "e": email,
      };
}

/// A central point for authorisation and defines a standardised way for
/// controlling access for widgets.
class SecureAccessController extends AppSecurity {
  late PermissionCollection permissions;
  final AppMode _mode;

  SecureAccessController(
    this._mode,
  ) {
    permissions = PermissionCollection(_mode);
  }

  authorise(SecureAppUser u) {
    permissions.create();
    u.setPermissions(permissions);
    if (u.email == '' && _mode == AppMode.mobile) {
      permissions.credentials = [SettingsView.viewIndex];
    }
  }
}

/// Stores permissions available for the application.
class PermissionCollection {
  final AppMode _mode;
  late List<int> credentials;

  PermissionCollection(
    this._mode,
  );

  create() {
    credentials = _mode.views;
  }
}

extension on AppMode {
  List<int> get views => this == AppMode.mobile
      ? [
          LandingView.viewIndex,
          SampleItemListView.viewIndex,
          SettingsView.viewIndex,
        ]
      : this == AppMode.desktop
          ? [
              LandingView.viewIndex,
              SampleItemListView.viewIndex,
              AdminView.viewIndex,
              SettingsView.viewIndex,
            ]
          : [
              LandingView.viewIndex,
              SampleItemListView.viewIndex,
              SettingsView.viewIndex,
            ];
  bool get canSave =>
      this == AppMode.mobile || this == AppMode.desktop ? true : false;
}
