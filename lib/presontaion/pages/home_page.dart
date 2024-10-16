// lib/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_code/domain/entities/user.dart';
import '../bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the authenticated user
    final authState = context.watch<AuthBloc>().state;

    User? user;
    if (authState is AuthAuthenticated) {
      user = authState.user;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutEvent());
            },
          ),
        ],
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (user.photoUrl != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl!),
                      radius: 40,
                    ),
                  SizedBox(height: 20),
                  Text('Hello, ${user.name}!'),
                  Text('Email: ${user.email}'),
                ],
              )
            : Text('No user information available.'),
      ),
    );
  }
}
