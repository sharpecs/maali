import 'package:maali/src/app_security.dart';

/// A class used to expose this application model domain and provide a simple
/// state management with usage of a controller.
///
/// see:
/// https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple
mixin AppProvider {
  SecureAppUser get appUser => SecureAppUser.anonymous;
  late SampleItem item;
}

class SampleItem {
  const SampleItem(this.id);

  final int id;
}
