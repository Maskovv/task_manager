import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/cubit/auth_cubit_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const String path = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/tasks'),
        ),
      ),
      body: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state) {
          if (state is AuthCubitAuthorized) {
            return ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Email'),
                  subtitle: Text(state.user.email ?? 'Нет email'),
                ),
                const ListTile(
                  leading: Icon(Icons.verified),
                  title: Text('Статус аккаунта'),
                  subtitle: Text('Верифицирован'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Выйти'),
                  onTap: AuthCubit.i(context).signOut,
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}