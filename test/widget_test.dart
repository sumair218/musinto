// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musinto/screens/complete_profile_screen.dart';
import 'package:musinto/screens/home_screen.dart';
import 'package:musinto/screens/library_screen.dart';
import 'package:musinto/screens/login_email_screen.dart';
import 'package:musinto/screens/login_mobile_screen.dart';
import 'package:musinto/screens/otp_screen.dart';
import 'package:musinto/screens/language_screen.dart';
import 'package:musinto/screens/playlist_screen.dart';
import 'package:musinto/screens/player_screen.dart';
import 'package:musinto/screens/splash_screen.dart';
import 'package:musinto/core/theme.dart';

void main() {
  testWidgets('splash screen displays the SVG brand logo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: buildTheme(), home: const SplashScreen()),
    );

    expect(find.byKey(const Key('app-logo')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home screen adapts to phone, tablet, and desktop widths', (
    tester,
  ) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final size in const [
      Size(360, 780),
      Size(820, 1024),
      Size(1440, 900),
    ]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      await tester.pumpWidget(
        MaterialApp(
          theme: buildTheme(),
          home: const Scaffold(body: HomeScreen()),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull, reason: 'Viewport: $size');
      expect(find.text('Good Morning'), findsOneWidget);
      expect(find.text('Quick Play'), findsOneWidget);
      expect(find.text('Daily Mix'), findsOneWidget);
      expect(find.byType(Image), findsWidgets);
    }
  });

  testWidgets('library and playlist show artwork responsively', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final size in const [Size(360, 780), Size(1440, 900)]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;

      await tester.pumpWidget(
        MaterialApp(
          theme: buildTheme(),
          home: const Scaffold(body: LibraryScreen()),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull, reason: 'Library viewport: $size');
      expect(find.text('Music Library'), findsOneWidget);
      expect(find.byType(Image), findsWidgets);

      await tester.pumpWidget(
        MaterialApp(theme: buildTheme(), home: const PlaylistScreen()),
      );
      await tester.pump();
      expect(tester.takeException(), isNull,
          reason: 'Playlist viewport: $size');
      expect(find.text('Edm House - By Unimagines'), findsOneWidget);
      expect(find.byType(Image), findsWidgets);
    }
  });

  testWidgets('email login fits the reference phone layout', (tester) async {
    tester.view.physicalSize = const Size(470, 1010);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: buildTheme(), home: const LoginEmailScreen()),
    );

    final exception = tester.takeException();
    expect(exception, isNull);
    expect(find.text('Over'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Continue With Mobile'), findsOneWidget);
  });

  testWidgets('mobile login shows the India flag and dialing code', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(470, 1010);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: buildTheme(), home: const LoginMobileScreen()),
    );

    expect(tester.takeException(), isNull);
    expect(find.byKey(const Key('country-selector')), findsOneWidget);
    expect(find.text('+91'), findsOneWidget);
    expect(find.text('Enter Mobile Number'), findsOneWidget);

    await tester.tap(find.byKey(const Key('country-selector')));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNWidgets(2));

    await tester.enterText(find.byType(TextField).last, 'Canada');
    await tester.pumpAndSettle();
    expect(find.text('Canada'), findsNWidgets(2));
    await tester.tap(find.text('Canada').last);
    await tester.pumpAndSettle();
    expect(find.text('+1'), findsOneWidget);
    expect(find.text('+91'), findsNothing);
  });

  testWidgets('language screen supports multiple selections', (tester) async {
    tester.view.physicalSize = const Size(470, 1010);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: buildTheme(), home: const LanguageScreen()),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Select Your Music\nLanguage'), findsOneWidget);
    expect(find.byKey(const Key('language-option-0')), findsOneWidget);

    await tester.tap(find.byKey(const Key('language-option-0')));
    await tester.pump();

    final hindi = tester.widget<AnimatedContainer>(find.descendant(
      of: find.byKey(const Key('language-option-0')),
      matching: find.byType(AnimatedContainer),
    ));
    final decoration = hindi.decoration as BoxDecoration;
    expect(decoration.border!.top.color, AppColors.pink);
  });

  testWidgets('player switches to the local rotating vinyl asset', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(470, 1010);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: buildTheme(), home: const PlayerScreen()),
    );

    expect(find.byKey(const Key('player-vinyl-image')), findsNothing);
    await tester.tap(find.byKey(const Key('player-artwork')));
    await tester.pump();

    expect(find.byKey(const Key('player-vinyl-image')), findsOneWidget);
    expect(tester.takeException(), isNull);

    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(
      MaterialApp(theme: buildTheme(), home: const PlayerScreen()),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('OTP verification matches the phone layout', (tester) async {
    tester.view.physicalSize = const Size(470, 1010);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: buildTheme(), home: const OtpScreen()),
    );

    expect(tester.takeException(), isNull);
    expect(find.byKey(const Key('change-number')), findsOneWidget);
    expect(find.text('Verify'), findsOneWidget);
    expect(find.text('Resend Code in'), findsOneWidget);
    for (var index = 0; index < 6; index++) {
      expect(find.byKey(Key('otp-digit-$index')), findsOneWidget);
    }
  });

  testWidgets('profile screen scrolls above the keyboard', (tester) async {
    tester.view.physicalSize = const Size(470, 1010);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);

    await tester.pumpWidget(
      MaterialApp(
        theme: buildTheme(),
        home: const CompleteProfileScreen(),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);

    tester.view.viewInsets = const FakeViewPadding(bottom: 500);
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CounterTestApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

class CounterTestApp extends StatefulWidget {
  const CounterTestApp({super.key});

  @override
  State<CounterTestApp> createState() => _CounterTestAppState();
}

class _CounterTestAppState extends State<CounterTestApp> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text('$_counter')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => _counter++),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
