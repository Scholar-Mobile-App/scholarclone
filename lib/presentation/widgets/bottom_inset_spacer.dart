import 'package:flutter/material.dart';

/// Reserves the height of the system navigation bar below a [Scaffold] body.
///
/// The app targets Android 15+, where the system always draws the navigation
/// bar on top of the app. Without this the bottom of a screen - usually a Save
/// or Submit button - sits behind that bar: mostly hidden on phones with
/// navigation buttons, partly hidden on phones using gesture navigation.
///
/// Used as `bottomNavigationBar: const BottomInsetSpacer()`, so the [Scaffold]
/// keeps its body clear of the navigation bar while still painting its own
/// background behind it. It collapses to nothing while the keyboard is open,
/// because the keyboard already covers the navigation bar.
class BottomInsetSpacer extends StatelessWidget {
  const BottomInsetSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.paddingOf(context).bottom,
    );
  }
}
