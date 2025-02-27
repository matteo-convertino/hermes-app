import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';

LoaderOverlay getMyLoaderOverlay({required Widget child}) {
  return LoaderOverlay(
    child: child,
  );
}
