import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformPage extends StatelessWidget {
  final Widget? mobilePage;
  final Widget? windowsPage;

  const PlatformPage({
    Key? key,
    required this.mobilePage,
    required this.windowsPage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(defaultTargetPlatform){
      case TargetPlatform.android:
        return mobilePage!;
      case TargetPlatform.fuchsia:
        return windowsPage!;
      case TargetPlatform.iOS:
        return mobilePage!;
      case TargetPlatform.linux:
        return windowsPage!;
      case TargetPlatform.macOS:
        return windowsPage!;
      case TargetPlatform.windows:
        return windowsPage!;
    }
  }
}