// Basic smoke tests for the AquaLoop app.

import 'package:flutter_test/flutter_test.dart';

import 'package:aqualoops_app/main.dart';
import 'package:aqualoops_app/screens/auth/forgot_password_screen.dart';
import 'package:aqualoops_app/screens/auth/login_screen.dart';
import 'package:aqualoops_app/screens/auth/otp_screen.dart';
import 'package:aqualoops_app/screens/auth/set_new_password_screen.dart';
import 'package:aqualoops_app/screens/auth/splash_screen.dart';

void main() {
  testWidgets('shows the splash screen on launch', (WidgetTester tester) async {
    await tester.pumpWidget(const AquaLoopApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('AquaLoop'), findsOneWidget);
    expect(find.text('Pure Water Delivery'), findsOneWidget);

    // Flush the splash Timer so it isn't left pending at the end of the test.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  });

  testWidgets('navigates from splash to login after 2 seconds',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AquaLoopApp());

    // Advance past the splash Timer.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('forgot password → OTP opens the set password screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const AquaLoopApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Open Forgot Password from the login screen.
    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();
    expect(find.byType(ForgotPasswordScreen), findsOneWidget);

    // Send the OTP.
    await tester.tap(find.text('SEND OTP'));
    await tester.pumpAndSettle();
    expect(find.byType(OtpScreen), findsOneWidget);

    // Verify it → must land on Set New Password (not back on Login).
    await tester.tap(find.text('VERIFY OTP'));
    await tester.pumpAndSettle();

    expect(find.byType(SetNewPasswordScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);
  });
}
