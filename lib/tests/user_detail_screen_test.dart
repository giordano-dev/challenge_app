import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tecnofit_app/api/models/user_model.dart';
import 'package:tecnofit_app/ui/screens/user_detail_screen.dart';

// Mock class for User
class MockUser extends Mock implements User {}

void main() {
  late User mockUser;
  late User mockPrincipalUser;

  setUp(() {
    // Setup mock data
    mockUser = MockUser();
    when(() => mockUser.firstName).thenReturn('John');
    when(() => mockUser.lastName).thenReturn('Doe');
    when(() => mockUser.email).thenReturn('john.doe@example.com');
    when(() => mockUser.avatar).thenReturn('https://example.com/avatar.jpg');

    mockPrincipalUser = MockUser();
    when(() => mockPrincipalUser.firstName).thenReturn('Jane');
    when(() => mockPrincipalUser.lastName).thenReturn('Doe');
    when(() => mockPrincipalUser.email).thenReturn('jane.doe@example.com');
    when(() => mockPrincipalUser.avatar).thenReturn('https://example.com/avatar.jpg');
  });

  testWidgets('UserDetailScreen displays user details', (WidgetTester tester) async {
    // Pump the UserDetailScreen widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserDetailScreen(user: mockUser, principalUser: mockPrincipalUser),
      ),
    );

    // Verify that the user details are displayed correctly
    expect(find.text('JOHN DOE'), findsOneWidget);
    expect(find.text('john.doe@example.com'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('UserDetailScreen shows Logout button for principal user', (WidgetTester tester) async {
    // Pump the UserDetailScreen widget with the principal user being the same as the user
    await tester.pumpWidget(
      MaterialApp(
        home: UserDetailScreen(user: mockPrincipalUser, principalUser: mockPrincipalUser),
      ),
    );

    // Verify that the Logout button is displayed
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('UserDetailScreen does not show Logout button for non-principal user', (WidgetTester tester) async {
    // Pump the UserDetailScreen widget with a different user and principal user
    await tester.pumpWidget(
      MaterialApp(
        home: UserDetailScreen(user: mockUser, principalUser: mockPrincipalUser),
      ),
    );

    // Verify that the Logout button is not displayed
    expect(find.text('Logout'), findsNothing);
  });
}
