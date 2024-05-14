import 'package:flutter/material.dart';

import '../../../core/ui.dart';

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);

  static ThemeState get darkTheme => ThemeState(Themes.darkTheme);

  static ThemeState get lightTheme => ThemeState(Themes.defaultTheme);

}
