import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/foundation.dart';
import 'core/config/config.dart';
import 'core/router/app_router.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/auth/cubit/auth_cubit_state.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru_RU', null);
  
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAL8vpQLQ7ndZTe4VkrV7PAEV0X27Almgk',
        appId: '1:123524740924:web:1f27803be1f667027c9039',
        messagingSenderId: '123524740924',
        projectId: 'domashka-c897e',
        authDomain: 'domashka-c897e.firebaseapp.com',
        storageBucket: 'domashka-c897e.firebasestorage.app',
        measurementId: 'G-VDSXXSL92N',
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppConfiguration()),
        BlocProvider(
          create: (context) => AuthCubit(
            firebaseAuth: AppConfiguration.i(context).state.authInstance,
          ),
        ),
      ],
      child: BlocListener<AuthCubit, AuthCubitState>(
        listener: (context, state) {
          if (state is AuthCubitUnauthorized && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ошибка: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          AppRouter.router.refresh();
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: AppRouter.router,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ru', 'RU'),
          ],
          locale: const Locale('ru', 'RU'),
        ),
      ),
    );
  }
}