import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/cubit/auth_cubit_state.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/pages/sign_in_page.dart';
import '../../features/task/pages/task_list_page.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouterGuards {
  static String? authorized(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthCubit>().state;
    if (authState is! AuthCubitAuthorized) {
      return SignInPage.path;
    }
    return null;
  }

  static String? unauthorized(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthCubitAuthorized) {
      return TaskListPage.path;
    }
    return null;
  }
}