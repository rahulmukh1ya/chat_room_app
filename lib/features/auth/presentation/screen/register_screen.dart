import 'package:chat_app/common/theme/theme_extension.dart';
import 'package:chat_app/common/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _isObscure = ValueNotifier(false);
  final ValueNotifier<bool> _isObscureConfirm = ValueNotifier(false);

  Widget personAvatar() {
    return CircleAvatar(
      radius: MediaQuery.sizeOf(context).width * 0.1,
      child: Icon(Icons.person),
    );
  }

  void toggleVisibility() {
    _isObscure.value = !_isObscure.value;
  }

  void toggleVisibilityConfirmPassword() {
    _isObscureConfirm.value = !_isObscureConfirm.value;
  }

  void _navigateToLoginPage() {
    Navigator.pop(context);
  }

  void _handleRegistration() {}

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
              'Register User',
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
            ValueListenableBuilder(
              valueListenable: _isObscureConfirm,
              builder: (context, value, _) {
                return CustomTextFormField(
                  isObscure: value,
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    onPressed: toggleVisibilityConfirmPassword,

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
                onPressed: _handleRegistration,
                child: Text('Register'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: _navigateToLoginPage,
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
