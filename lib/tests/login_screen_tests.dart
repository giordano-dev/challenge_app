import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tecnofit_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:tecnofit_app/blocs/auth_bloc/auth_event.dart';
import 'package:tecnofit_app/blocs/auth_bloc/auth_state.dart';
import 'package:tecnofit_app/ui/screens/login_screen.dart';

// Mock do AuthBloc para testes
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  group('LoginScreen Widget Tests', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
    });

    testWidgets('Deve renderizar a tela de login corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (_) => mockAuthBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      expect(find.text('Bem-vindo ao Tecnofit App!'), findsOneWidget);
      expect(find.text('Olá!'), findsOneWidget);
      expect(find.text('Acesse a sua conta para visualizar os seus dados.'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget); // Botão de login
    });

    testWidgets('Botão de login deve estar desativado com campos vazios', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (_) => mockAuthBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      final ElevatedButton loginButton = tester.widget(find.byType(ElevatedButton));

      expect(loginButton.onPressed, isNull); // Botão desativado
    });

    // Teste de login com email e senha preenchidos
    testWidgets('Botão de login deve estar ativado com email e senha preenchidos', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (_) => mockAuthBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      // Preencher campos de texto
      await tester.enterText(find.byType(TextField).first, 'eve.holt@reqres.in');
      await tester.enterText(find.byType(TextField).last, 'cityslicka');

      await tester.pump(); // Atualiza a UI após inserir o texto

      final ElevatedButton loginButton = tester.widget(find.byType(ElevatedButton));
      expect(loginButton.onPressed, isNotNull); // Botão ativado
    });

    // Teste do disparo de evento AuthLoginEvent ao pressionar o botão de login
    testWidgets('Deve disparar AuthLoginEvent ao pressionar o botão de login', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (_) => mockAuthBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, 'eve.holt@reqres.in');
      await tester.enterText(find.byType(TextField).last, 'cityslicka');

      await tester.pump();
      // Simular clique no botão de login
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(() => mockAuthBloc.add(AuthLoginEvent('eve.holt@reqres.in', 'cityslicka'))).called(1);
    });

    // Teste de erro exibido após falha no login
    testWidgets('Deve exibir mensagem de erro ao falhar no login', (WidgetTester tester) async {
      whenListen(
        mockAuthBloc,
        Stream.fromIterable([AuthErrorState('Erro ao fazer login')]),
        initialState: AuthInitialState(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>(
            create: (_) => mockAuthBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.pump(); // Aguarda a atualização da tela

      // Verifica se a mensagem de erro é exibida
      expect(find.text('Erro ao fazer login'), findsOneWidget);
    });
  });
}
