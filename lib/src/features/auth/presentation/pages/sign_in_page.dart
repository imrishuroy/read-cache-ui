import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/validators/validators.dart';
import 'package:read_cache_ui/src/core/widgets/widgets.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';
import 'package:read_cache_ui/src/features/cache/presentation/pages/caches_list_page.dart';
import 'package:read_cache_ui/src/services/services.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static const name = 'SignInPage';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authBloc = getIt<AuthBloc>();

  @override
  void initState() {
    FirebaseAnalyticsService.logScreenViewEvent(SignInPage.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state.authStatus == AuthStatus.signedIn &&
              state.userStatus == UserStatus.authorized) {
            context.goNamed(CachesListPage.name);
          }
          if (state.authStatus == AuthStatus.signedIn &&
              state.userStatus == UserStatus.unAuthorized) {
            context.goNamed(
              CreateUserPage.name,
              pathParameters: {'email': _emailController.text},
            );
          }
          if (state.authStatus == AuthStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failure: ${state.failure?.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
          debugPrint('Auth State (Login) $state');
          return Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              decoration: const BoxDecoration(),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: state.authStatus == AuthStatus.loading
                      ? const CircularProgressIndicator()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Welcome to Read Cache 👋',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text('Sign in to continue'),
                            const SizedBox(height: 20),
                            CustomTextField(
                              textEditingController: _emailController,
                              hintText: 'Email',
                              validator: (value) =>
                                  Validator.validateEmail(value),
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              textEditingController: _passwordController,
                              hintText: 'Password',
                              validator: (value) =>
                                  Validator.validatePassword(value),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(400, 55),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: _signIn,
                              child: const Text('Sign in'),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () => context.goNamed(SignUpPage.name),
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(
        AuthSignedIn(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
