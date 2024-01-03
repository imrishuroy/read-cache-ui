import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/core/config/shared_prefs.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthUseCase authUseCase,
  })  : _authUseCase = authUseCase,
        super(AuthState.initial()) {
    on<AuthSignedIn>(_onAuthSignedIn);
    on<AuthSignedUp>(_onAuthSignedUp);
    on<AuthUserCreated>(_onAuthUserCreated);
    on<AuthSignOutRequested>(_onAuthSignOutRequested);
  }
  final AuthUseCase _authUseCase;

  Future<void> _onAuthSignedIn(
    AuthSignedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        authStatus: AuthStatus.loading,
      ),
    );

    final userCredRes = await _authUseCase.signIn(
      email: event.email,
      password: event.password,
    );

    userCredRes.fold(
      (failure) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.failure,
            failure: failure,
          ),
        );
      },
      (userCredential) {
        emit(
          state.copyWith(
            firebaseUser: userCredential?.user,
          ),
        );
      },
    );
    if (state.firebaseUser != null) {
      final idToken = await state.firebaseUser?.getIdToken();

      if (idToken != null) {
        await SharedPrefs.setToken(token: idToken);
      }

      final userRes = await _authUseCase.getUser(
        id: state.firebaseUser?.uid,
      );

      await userRes.fold(
        (failure) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.signedIn,
              failure: failure,
            ),
          );
        },
        (user) async {
          await SharedPrefs.setAppUser(
            appUser: AppUser(
              id: user?.id,
              email: user?.email,
              name: user?.name,
            ),
          );
          emit(
            state.copyWith(
              user: user,
              authStatus: AuthStatus.signedIn,
              userStatus: UserStatus.authorized,
            ),
          );
        },
      );
    }
  }

  Future<void> _onAuthSignedUp(
    AuthSignedUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        authStatus: AuthStatus.loading,
      ),
    );

    final userCredRes = await _authUseCase.signUp(
      email: event.email,
      password: event.password,
    );
    userCredRes.fold(
      (failure) {
        emit(
          state.copyWith(
            failure: failure,
            authStatus: AuthStatus.failure,
          ),
        );
      },
      (userCredential) {
        emit(
          state.copyWith(
            firebaseUser: userCredential?.user,
            authStatus: AuthStatus.signedUp,
          ),
        );
      },
    );

    final idToken = await state.firebaseUser?.getIdToken();
    debugPrint('token $idToken');

    if (idToken != null) {
      await SharedPrefs.setToken(token: idToken);
    }
  }

  Future<void> _onAuthUserCreated(
    AuthUserCreated event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        authStatus: AuthStatus.loading,
      ),
    );
    final response = await _authUseCase.createUser(
      createUserReqDto: CreateUserReqDto(
        email: event.email,
        name: event.name,
      ),
    );

    await response.fold(
      (failure) {
        emit(
          state.copyWith(
            failure: failure,
            authStatus: AuthStatus.failure,
          ),
        );
      },
      (user) async {
        await SharedPrefs.setAppUser(
          appUser: AppUser(
            id: user?.id,
            email: user?.email,
            name: user?.name,
          ),
        );
        emit(
          state.copyWith(
            userStatus: UserStatus.authorized,
            user: user,
          ),
        );
      },
    );
  }

  Future<void> _onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authUseCase.signOut();
    await SharedPrefs.clear();
    emit(
      AuthState.initial(),
    );
  }
}
