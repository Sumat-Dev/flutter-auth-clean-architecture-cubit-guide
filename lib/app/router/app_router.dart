import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/presentation/pages/profile_page.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/presentation/pages/splash_page.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/home/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

/// App router configuration
class AppRouter {
  /// Creates the router configuration
  static GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: [
      // Splash page
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      
      // Auth routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      
      // Main app routes
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
    
    // Redirect logic based on authentication status
    redirect: (context, state) {
      // You can implement authentication logic here
      // For now, we'll just allow all routes
      return null;
    },
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
