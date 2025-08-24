import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/presentation/state/cubit/auth_cubit.dart';
import 'package:flutter_clean_architecture_cubit_guide/features/auth/presentation/state/cubit/auth_state.dart';
import 'package:go_router/go_router.dart';

/// Custom app bar for the home page
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      centerTitle: true,
      actions: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => context.go('/profile'),
                tooltip: 'Profile',
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
