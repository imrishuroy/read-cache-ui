import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/validators/validators.dart';
import 'package:read_cache_ui/src/core/widgets/widgets.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';
import 'package:read_cache_ui/src/services/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const name = 'SignUpPage';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authBloc = getIt<AuthBloc>();

  @override
  void initState() {
    FirebaseAnalyticsService.logScreenViewEvent(SignUpPage.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state.authStatus == AuthStatus.signedUp) {
            context.goNamed(
              CreateUserPage.name,
              pathParameters: {'email': _emailController.text},
            );
          }
          if (state.authStatus == AuthStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.failure?.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
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
                            const Text('Sign Up to continue'),
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
                              onPressed: _signUp,
                              child: const Text('Sign Up'),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () => context.go('/signin'),
                              child: const Text('Sign In'),
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

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(
        AuthSignedUp(
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
