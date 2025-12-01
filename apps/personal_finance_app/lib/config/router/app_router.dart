import 'package:auth/presentation/bloc/auth_bloc.dart';
import 'package:auth/presentation/pages/login_page.dart';
import 'package:auth/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';

import '../../dashboard_page.dart';
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
            (context, state) => LoginPage(
              onRegisterTap: () => context.push('/register'),
            ),
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
          return DashboardPage();
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
