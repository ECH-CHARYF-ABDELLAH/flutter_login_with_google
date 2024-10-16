// lib/data/repositories/auth_repository_impl.dart
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._googleSignIn);

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return null; // User cancelled

      return User(
        id: account.id,
        name: account.displayName ?? '',
        email: account.email,
        photoUrl: account.photoUrl,
      );
    } catch (e) {
      // Handle errors appropriately
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
