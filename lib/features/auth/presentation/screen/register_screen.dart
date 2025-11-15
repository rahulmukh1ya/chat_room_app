import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        border: OutlineInputBorder(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Text('Register User'),
          personAvatar(),
          inputFormField(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
