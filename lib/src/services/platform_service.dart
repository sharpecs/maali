import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maali/src/app_service.dart';

/// Applies a plugin for finding commonly used locations on the filesystem.
class PlatformService implements AppService {
  @override
  Future<ThemeMode> themeMode() async => ThemeMode.light;

  @override
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }

  // 1. Set the correct local path (in Documents directory).
  Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();

    return 'directory.path';
  }

  // 2. Create a reference to the file location.
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/observation.txt');
  }
}
