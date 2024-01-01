part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  failure,
}

class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.user,
    //  this.user,
    this.failure,
  });
  factory AuthState.initial() => const AuthState(
        status: AuthStatus.initial,
      );

  final AuthStatus status;
  final User? user;
  // final AppUser? user;
  final Failure? failure;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    //AppUser? user,
    Failure? failure,
  }) {
    return AuthState(
      status: status ?? this.status,
      // userCredential: userCredential ?? this.userCredential,
      user: user ?? this.user,
      failure: failure ?? this.failure,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        status,
        // userCredential,
        user,
        failure,
      ];
}
