part of '../domain.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(email: params.email);
  }
}

class ResetPasswordParams extends Equatable {
  final String email;

  const ResetPasswordParams({required this.email});

  @override
  List<Object> get props => [email];
}
