import 'package:chatroom/app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  _addFontsLicense();

  runApp(const ChatRoomApp());
}

void _addFontsLicense() {
  // Disable HTTP fetching of fonts at runtime
  GoogleFonts.config.allowRuntimeFetching = false;

  LicenseRegistry.addLicense(() async* {
    final inconsolataFontLicense = await rootBundle.loadString('assets/fonts/google_fonts/inconsolata/OFL.txt');

    yield LicenseEntryWithLineBreaks(['google_fonts'], inconsolataFontLicense);
  });
}
