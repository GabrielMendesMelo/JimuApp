// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/foundation.dart';

class Config {
  static bool get isDesktop =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  static String get initialRoute => '/alimentos';
}
