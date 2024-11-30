import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const String path = '/';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Пароль',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => AuthCubit.i(context).signIn(
                _emailController.text,
                _passwordController.text,
              ),
              child: const Text('Войти'),
            ),
            TextButton(
              onPressed: () => context.go('/sign_up'),
              child: const Text('Регистрация'),
            ),
          ],
        ),
      ),
    );
  }
}