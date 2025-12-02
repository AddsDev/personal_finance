import 'package:auth/presentation/bloc/auth_bloc.dart';
import 'package:auth/presentation/pages/login_page.dart';
import 'package:auth/presentation/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:transactions/domain/entities/transaction.dart';
import 'package:transactions/presentation/pages/transaction_form_page.dart';
import 'package:transactions/presentation/pages/transaction_detail_page.dart';

import '../../presentation/dashboard/dashboard_page.dart';
import '../../presentation/stats/pages/stats_page.dart';
import 'go_router_refresh_stream.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/dashboard'),
      GoRoute(
        path: '/login',
        builder:
            (context, state) =>
                LoginPage(onRegisterTap: () => context.push('/register')),
      ),

      GoRoute(
        path: '/register',
        builder:
            (context, state) => RegisterPage(
              onRegisterSuccess: () => context.go('/dashboard'),
              onLoginTap: () => context.go('/login'),
            ),
      ),

      GoRoute(
        path: '/dashboard',
        builder: (context, state) {
          return DashboardPage(
            onAddTransactionTap:
                (userId) => context.push('/add-transaction', extra: userId),
          );
        },
      ),

      GoRoute(
        path: '/add-transaction',
        builder: (_, state) {
          return TransactionFormPage(userId: state.extra as String);
        },
      ),

      GoRoute(
        path: '/edit-transaction',
        builder: (context, state) {
          final transaction = state.extra as TransactionEntity;
          return TransactionFormPage(
            transactionToEdit: transaction,
            userId: transaction.userId,
          );
        },
      ),
      GoRoute(
        path: '/transaction-detail',
        builder: (context, state) {
          final transaction = state.extra as TransactionEntity;
          return TransactionDetailPage(
            transaction: transaction,
            onEditTransaction:
                (TransactionEntity transactionToEdit) =>
                    context.pushReplacement(
                      '/edit-transaction',
                      extra: transactionToEdit,
                    ),
          );
        },
      ),
      GoRoute(
        path: '/stats',
        builder: (context, state) {
          final userId = state.extra as String;
          return StatsPage(userId: userId);
        },
      ),
    ],
    redirect: (context, state) {
      final authState = authBloc.state;
      final isAuthenticated = authState.status == AuthStatus.authenticated;

      final isLoginRoute = state.matchedLocation == '/login';
      final isRegisterRoute = state.matchedLocation == '/register';

      if (!isAuthenticated && !isLoginRoute && !isRegisterRoute) {
        return '/login';
      }

      if (isAuthenticated && (isLoginRoute || isRegisterRoute)) {
        return '/dashboard';
      }

      return null;
    },
  );
}
