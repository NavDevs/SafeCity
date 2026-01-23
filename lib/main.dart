import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/app_wrapper.dart';
import 'providers/states_provider.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const GuardianGoApp());
}

class GuardianGoApp extends StatelessWidget {
  const GuardianGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StatesProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return MaterialApp(
            title: 'Safe City - Your Safety Companion',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.grey,
                brightness: Brightness.light,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[700],
                foregroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.black,
                brightness: Brightness.dark,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            themeMode: userProvider.themeMode,
            home: const AppWrapper(),
          );
        },
      ),
    );
  }
}
