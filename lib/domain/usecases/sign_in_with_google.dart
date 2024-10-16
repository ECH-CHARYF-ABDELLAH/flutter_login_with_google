// lib/domain/usecases/sign_in_with_google.dart
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<User?> execute() {
    return repository.signInWithGoogle();
  }
}
