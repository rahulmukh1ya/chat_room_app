import 'package:chat_app/common/theme/theme_extension.dart';
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

  Widget inputFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool isObscure = false,
    VoidCallback? callBack,
    Icon? prefixIcon,
    IconButton? suffixIcon,
  }) {
    return TextFormField(
      onTap: callBack,
      controller: controller,
      obscureText: isObscure,

      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: hintText,
        label: Text(label),
      ),
    );
  }

  Widget personAvatar() {
    return CircleAvatar(
      radius: MediaQuery.sizeOf(context).width * 0.1,
      child: Icon(Icons.person),
    );
  }

  void toggleVisibility() {
    _isObscure.value = !_isObscure.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text(
              'Login User',
              style: context.headline2.copyWith(color: Colors.red),
            ),
            personAvatar(),
            inputFormField(
              prefixIcon: Icon(Icons.person_outline),
              controller: _usernameController,
              label: 'Username',
              hintText: 'Enter username here',
            ),
            ValueListenableBuilder(
              valueListenable: _isObscure,
              builder: (context, value, _) {
                return inputFormField(
                  isObscure: value,
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Enter password here',
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
          ],
        ),
      ),
    );
  }
}
