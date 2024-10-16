// lib/domain/usecases/sign_out.dart
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> execute() {
    return repository.signOut();
  }
}
