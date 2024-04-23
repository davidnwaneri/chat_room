import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData dark() {
    return FlexColorScheme.dark(
      scheme: FlexScheme.materialBaseline,
      appBarElevation: 2,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      typography: Typography.material2021(platform: defaultTargetPlatform),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useTextTheme: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: GoogleFonts.inconsolata().fontFamily,
    ).toTheme;
  }
}
