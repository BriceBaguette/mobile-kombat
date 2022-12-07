import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    Auth auth = Auth();
    if (auth.currentUser != null) {
      auth.initializeUser();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.popAndPushNamed(context, 'menu');
      });
    }
    return Align(
        child: SizedBox(
            width: 600,
            height: 300,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  onChanged: (value) => email = value,
                  validator: (String? value) {
                    return (value != null && value.contains('@'))
                        ? null
                        : 'Insert a valid email adress';
                  },
                ),
                TextFormField(
                    decoration: const InputDecoration(
                      labelText: "password",
                    ),
                    obscureText: true,
                    onChanged: (value) => password = value,
                    validator: (String? value) {
                      return (null);
                    }),
                const SizedBox(
                  width: double.infinity,
                  height: 20,
                ),
                ElevatedButton(
                  child: (const Text('Sign in')),
                  onPressed: () => {
                    auth.signIn(email, password),
                    if (auth.currentUser != null)
                      {
                        Navigator.of(context).popAndPushNamed('menu'),
                      }
                    else
                      {}
                  },
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 20,
                ),
                ElevatedButton(
                  child: (const Text('Go to register')),
                  onPressed: () =>
                      Navigator.of(context).popAndPushNamed('register'),
                )
              ],
            ))));
  }
}
