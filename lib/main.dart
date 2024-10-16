import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_code/domain/repositories/auth_repository_impl.dart';
import 'package:test_code/presontaion/bloc/auth_bloc.dart';
import 'package:test_code/presontaion/pages/home_page.dart';
import 'package:test_code/presontaion/pages/login_page.dart';

import 'domain/usecases/sign_in_with_google.dart';
import 'domain/usecases/sign_out.dart';


void main() {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final AuthRepositoryImpl authRepository = AuthRepositoryImpl(googleSignIn);
  final SignInWithGoogleUseCase signInUseCase =
      SignInWithGoogleUseCase(authRepository);
  final SignOutUseCase signOutUseCase = SignOutUseCase(authRepository);

  runApp(MyApp(
    authBloc: AuthBloc(
      signInWithGoogle: signInUseCase,
      signOut: signOutUseCase,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;

  const MyApp({Key? key, required this.authBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => authBloc,
      child: MaterialApp(
        title: 'Google Sign-In with BLoC & DDD',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
