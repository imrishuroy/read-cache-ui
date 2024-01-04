import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:read_cache_ui/src/core/config/injection_container.dart';
import 'package:read_cache_ui/src/core/validators/validators.dart';
import 'package:read_cache_ui/src/core/widgets/widgets.dart';
import 'package:read_cache_ui/src/features/auth/presentation/presentation.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({
    required this.email,
    super.key,
  });

  final String? email;

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _authBloc = getIt<AuthBloc>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    if (widget.email != null) {
      _emailController.text = widget.email!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state.userStatus == UserStatus.authorized) {
            context.go('/caches');
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
          debugPrint('Auth State ( Create User ) $state');
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
                              'Hi there👋',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text('Create account to continue'),
                            const SizedBox(height: 20),
                            CustomTextField(
                              textEditingController: _emailController,
                              hintText: 'Email',
                              validator: (value) =>
                                  Validator.validateEmail(value),
                              readOnly: true,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              textEditingController: _nameController,
                              hintText: 'Name',
                              validator: (value) =>
                                  Validator.validateName(value),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(400, 55),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: _createAccount,
                              child: const Text('Create an account'),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () => context.go('/signin'),
                              child: const Text('Go back'),
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

  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(
        AuthUserCreated(
          email: _emailController.text,
          name: _nameController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
