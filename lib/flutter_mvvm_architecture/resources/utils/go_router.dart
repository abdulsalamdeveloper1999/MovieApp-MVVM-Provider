import 'package:go_router/go_router.dart';

import '../../view/home_screen.dart';
import '../../view/login_screen.dart';
import '../../view/sign_up_screen.dart';
import '../../view/splash_screen.dart';
import 'routes_name.dart';

class RouterHelper {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: RoutesName.splash,
        builder: (context, state) => const SplashScreenMvvm(),
      ),
      GoRoute(
        path: RoutesName.login,
        builder: (context, state) => const LoginScreenMvvm(),
      ),
      GoRoute(
        path: RoutesName.signup,
        builder: (context, state) => const SignUpScreenMvvm(),
      ),
      GoRoute(
        path: RoutesName.menu,
        builder: (context, state) => const MenuScreen(),
      )
    ],
  );
}
