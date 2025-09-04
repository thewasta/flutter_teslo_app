import 'package:go_router/go_router.dart';
import 'package:teslo_app/src/authentication/presentation/presentation.dart';
import 'package:teslo_app/src/shared/presentation/presentation.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
  ],
);
