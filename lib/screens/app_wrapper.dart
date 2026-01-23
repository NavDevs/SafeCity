import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'login_page.dart';
import 'guardian_go_home_page.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        // Show loading screen while checking authentication
        if (userProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              ),
            ),
          );
        }

        // Show login page if user is not logged in
        if (!userProvider.isLoggedIn) {
          return const LoginPage();
        }

        // Show home page if user is logged in
        return const GuardianGoHomePage();
      },
    );
  }
}
