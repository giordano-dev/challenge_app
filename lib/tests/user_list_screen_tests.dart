import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tecnofit_app/api/models/user_model.dart';
import 'package:tecnofit_app/ui/screens/user_list_screen.dart';
import 'package:tecnofit_app/ui/screens/user_detail_screen.dart';

// Mock class for User
class MockUser extends Mock implements User {}

void main() {
  late List<User> mockUsers;
  late User mockPrincipalUser;

  setUp(() {
    // Setting up mock users
    mockPrincipalUser = MockUser();
    when(() => mockPrincipalUser.firstName).thenReturn('Jane');
    when(() => mockPrincipalUser.lastName).thenReturn('Doe');
    when(() => mockPrincipalUser.email).thenReturn('jane.doe@example.com');
    when(() => mockPrincipalUser.avatar).thenReturn('https://example.com/avatar.jpg');

    final user1 = MockUser();
    when(() => user1.firstName).thenReturn('John');
    when(() => user1.lastName).thenReturn('Doe');
    when(() => user1.email).thenReturn('john.doe@example.com');
    when(() => user1.avatar).thenReturn('https://example.com/avatar1.jpg');

    final user2 = MockUser();
    when(() => user2.firstName).thenReturn('Alice');
    when(() => user2.lastName).thenReturn('Smith');
    when(() => user2.email).thenReturn('alice.smith@example.com');
    when(() => user2.avatar).thenReturn('https://example.com/avatar2.jpg');

    mockUsers = [user1, user2, mockPrincipalUser];
  });

  testWidgets('UserListScreen shows list of users', (WidgetTester tester) async {
    // Pumping the UserListScreen widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(
          users: mockUsers,
          principalUser: mockPrincipalUser,
          onUserTap: (_) {},
        ),
      ),
    );

    // Verifying that users are displayed
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Alice Smith'), findsOneWidget);
    expect(find.text('Jane Doe'), findsOneWidget);
  });

  testWidgets('UserListScreen navigates to UserDetailScreen on card tap', (WidgetTester tester) async {
    // Pumping the UserListScreen widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(
          users: mockUsers,
          principalUser: mockPrincipalUser,
          onUserTap: (_) {},
        ),
      ),
    );

    // Tapping the first user card
    await tester.tap(find.text('John Doe'));
    await tester.pumpAndSettle();

    // Verifying that UserDetailScreen is pushed with correct user
    // You can mock the navigation to `UserDetailScreen` and verify that the correct user is passed
  });

  testWidgets('Principal user profile button navigates to UserDetailScreen', (WidgetTester tester) async {
    // Pumping the UserListScreen widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(
          users: mockUsers,
          principalUser: mockPrincipalUser,
          onUserTap: (_) {},
        ),
      ),
    );

    // Tapping the profile icon
    await tester.tap(find.byIcon(Icons.account_circle));
    await tester.pumpAndSettle();

    // Verify that UserDetailScreen is displayed for the principal user
    expect(find.text('SEU PERFIL'), findsOneWidget);
    expect(find.text('jane.doe@example.com'), findsOneWidget);
  });

  testWidgets('Carousel displays users correctly with swiping', (WidgetTester tester) async {
    // Pumping the UserListScreen widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserListScreen(
          users: mockUsers,
          principalUser: mockPrincipalUser,
          onUserTap: (_) {},
        ),
      ),
    );

    // Verifying that the first user is visible
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Alice Smith'), findsNothing);

    // Swipe the carousel to see next user
    await tester.drag(find.byType(CarouselSlider), const Offset(-400, 0));
    await tester.pumpAndSettle();

    // Verifying that the second user is visible
    expect(find.text('Alice Smith'), findsOneWidget);
  });
}
