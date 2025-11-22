import 'dart:developer';

import 'package:chat_app/common/theme/theme_extension.dart';
import 'package:chat_app/common/utils/custom_snack_bar.dart';
import 'package:chat_app/common/utils/validators.dart';
import 'package:chat_app/common/widgets/custom_text_form_field.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/screen/register_screen.dart';
import 'package:chat_app/features/chat/presentation/screen/chat_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  final _formKey = GlobalKey<FormState>();

  void toggleVisibility() {
    _isObscure.value = !_isObscure.value;
  }

  void _navigateToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void _navigateChatListScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatListScreen()),
    );
  }

  void _handleLogin() {
    log('i am here');
    if (_formKey.currentState?.validate() ?? false) {
      log('here too??');

      context.read<AuthBloc>().add(
        LoginEvent(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.loginSuccess) {
          CustomSnackbar.show(context, state.message, SnackbarType.success);
          _navigateChatListScreen();
        } else if (state.status == AuthStatus.loginError) {
          CustomSnackbar.show(context, state.message, SnackbarType.error);
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Text(
                  'Login User',
                  style: context.largeTitle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomTextFormField(
                  prefixIcon: Icon(Icons.person_outline),
                  controller: _usernameController,
                  hintText: 'Username',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validators.validateUsername,
                ),
                ValueListenableBuilder(
                  valueListenable: _isObscure,
                  builder: (context, value, _) {
                    return CustomTextFormField(
                      isObscure: value,
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: Validators.validatePassword,

                      suffixIcon: IconButton(
                        onPressed: toggleVisibility,

                        icon: value
                            ? Icon(Icons.visibility_off_outlined)
                            : Icon(Icons.visibility_outlined),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 5),
                        ),
                        onPressed: _handleLogin,
                        child: state.status == AuthStatus.loading
                            ? SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text('Login'),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.all(0),
                      ),
                      onPressed: _navigateToRegisterPage,
                      child: Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
