import 'package:chat_app/common/theme/theme_extension.dart';
import 'package:chat_app/common/widgets/custom_text_form_field.dart';
import 'package:chat_app/features/auth/presentation/screen/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isObscure = ValueNotifier(false);

  Widget personAvatar() {
    return CircleAvatar(
      radius: MediaQuery.sizeOf(context).width * 0.1,
      child: Icon(Icons.person),
    );
  }

  void toggleVisibility() {
    _isObscure.value = !_isObscure.value;
  }

  void _navigateToRegisterPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  void _handleLogin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text(
              'Login User',
              style: context.largeTitle.copyWith(fontWeight: FontWeight.w500),
            ),
            // personAvatar(),
            CustomTextFormField(
              prefixIcon: Icon(Icons.person_outline),
              controller: _usernameController,
              label: 'Username',
            ),
            ValueListenableBuilder(
              valueListenable: _isObscure,
              builder: (context, value, _) {
                return CustomTextFormField(
                  isObscure: value,
                  controller: _passwordController,
                  label: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                onPressed: _handleLogin,
                child: Text('Login'),
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
    );
  }
}
