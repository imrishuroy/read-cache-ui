import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_cache_ui/src/core/config/failure.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/features/auth/data/data.dart';
import 'package:read_cache_ui/src/features/auth/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthUseCase authUseCase,
  })  : _authUseCase = authUseCase,
        super(AuthState.initial()) {
    _userSubscription = FirebaseAuth.instance.authStateChanges().listen(
          (user) => add(AuthUserChanged(user: user)),
        );
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthSigned>(_onAuthSigned);
  }
  final AuthUseCase _authUseCase;
  late StreamSubscription<User?> _userSubscription;

  Future<void> _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user != null) {
      emit(
        state.copyWith(
          user: event.user,
          status: AuthStatus.authenticated,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
        ),
      );
    }
  }

  Future<void> _onAuthLoggedIn(
    AuthLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
      ),
    );

    final userCredRes = await _authUseCase.login(
      email: event.email,
      password: event.password,
    );

    userCredRes.fold(
      (failure) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
          ),
        );
      },
      (userCredential) {
        emit(
          state.copyWith(
            user: userCredential?.user,
            //  status: AuthStatus.authenticated,
          ),
        );
      },
    );

    final idToken = await state.user?.getIdToken();
    debugPrint('token $idToken');

    final sharedPrefs = getIt<SharedPreferences>();

    if (idToken != null) {
      await sharedPrefs.setString('token', idToken);
    }

    final userRes = await _authUseCase.getUser(
      id: state.user?.uid,
    );

    debugPrint('user res $userRes');

    userRes.fold(
      (failure) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            failure: failure,
          ),
        );
      },
      (user) {
        debugPrint('Db user $user');
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
          ),
        );
      },
    );
  }

  Future<void> _onAuthSigned(
    AuthSigned event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
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
            status: AuthStatus.failure,
          ),
        );
      },
      (userCredential) {
        emit(
          state.copyWith(
            user: userCredential?.user,
            status: AuthStatus.authenticated,
          ),
        );
      },
    );

    final idToken = await state.user?.getIdToken();
    debugPrint('token $idToken');

    final sharedPrefs = getIt<SharedPreferences>();

    if (idToken != null) {
      await sharedPrefs.setString('token', idToken);
    }

    final userRes = await _authUseCase.createUser(
      signUpReqDto: SignUpReqDto(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    userRes.fold(
      (failure) {
        emit(
          state.copyWith(
            failure: failure,
            status: AuthStatus.unauthenticated,
          ),
        );
      },
      (user) {
        debugPrint('created user $user');
      },
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
