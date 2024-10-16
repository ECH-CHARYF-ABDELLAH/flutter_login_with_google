// lib/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Listen to AuthState
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Navigate to Home Page or wherever
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.login),
              label: Text('Sign in with Google'),
              onPressed: () {
                // Trigger SignIn event
                context.read<AuthBloc>().add(SignInWithGoogleEvent());
              },
            ),
          );
        },
      ),
    );
  }
}
