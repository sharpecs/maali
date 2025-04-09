import 'package:flutter/material.dart';

export 'package:maali/src/services/platform_service.dart';

/// Centralises logic across several services and aggregates behavior
/// to provide a uniform service layer for the AppController.
abstract class AppService {
  // colour theme mode for application.
  Future<ThemeMode> themeMode();

  // operation to update colour theme mode for application.
  Future<void> updateThemeMode(ThemeMode theme);
}
