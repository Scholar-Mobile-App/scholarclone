import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scholar_clone/presentation/widgets/bottom_inset_spacer.dart';

/// A screen shaped like the ones in this app: a long form inside a scroll
/// view with the Save button as the very last thing in it.
Future<void> pumpScreen(
  WidgetTester tester, {
  required double navigationBar,
  double keyboard = 0,
}) {
  return tester.pumpWidget(
    MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          viewPadding: EdgeInsets.only(bottom: navigationBar),
          viewInsets: EdgeInsets.only(bottom: keyboard),
          padding: EdgeInsets.only(
            bottom: (navigationBar - keyboard).clamp(0, navigationBar),
          ),
        ),
        child: child!,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 2000, color: Colors.grey),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Save"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: const BottomInsetSpacer(),
      ),
    ),
  );
}

void main() {
  testWidgets('Save button clears a button navigation bar', (tester) async {
    const double navigationBar = 48;
    await pumpScreen(tester, navigationBar: navigationBar);
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -3000));
    await tester.pump();

    final double screenBottom = tester.getSize(find.byType(MaterialApp)).height;
    final Rect button = tester.getRect(find.byType(ElevatedButton));
    expect(button.bottom, lessThanOrEqualTo(screenBottom - navigationBar));
  });

  testWidgets('Save button clears a gesture navigation bar', (tester) async {
    const double navigationBar = 24;
    await pumpScreen(tester, navigationBar: navigationBar);
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -3000));
    await tester.pump();

    final double screenBottom = tester.getSize(find.byType(MaterialApp)).height;
    final Rect button = tester.getRect(find.byType(ElevatedButton));
    expect(button.bottom, lessThanOrEqualTo(screenBottom - navigationBar));
  });

  testWidgets('spacer reserves exactly the navigation bar height',
      (tester) async {
    await pumpScreen(tester, navigationBar: 48);
    expect(tester.getSize(find.byType(BottomInsetSpacer)).height, 48);
  });

  testWidgets('spacer collapses while the keyboard covers the bar',
      (tester) async {
    await pumpScreen(tester, navigationBar: 48, keyboard: 300);
    expect(tester.getSize(find.byType(BottomInsetSpacer)).height, 0);
  });
}
