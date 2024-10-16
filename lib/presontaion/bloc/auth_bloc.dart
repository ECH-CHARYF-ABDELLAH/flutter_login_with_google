// lib/presentation/bloc/auth_bloc.dart


import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_code/domain/entities/user.dart';

import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/sign_out.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUseCase signInWithGoogle;
  final SignOutUseCase signOut;

  AuthBloc({
    required this.signInWithGoogle,
    required this.signOut,
  }) : super(AuthInitial()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signInWithGoogle.execute();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signOut.execute();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
