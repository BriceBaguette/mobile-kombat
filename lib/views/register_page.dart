import 'package:flutter/material.dart';
import 'package:mobile_kombat/models/auth.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';
    Auth auth = Auth();
    String nickname = '';
    return Align(
        child: SizedBox(
            width: 600,
            height: 320,
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
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "nickname",
                      ),
                      onChanged: (value) => nickname = value,
                      validator: (String? value) {
                        return (value != null) ? null : 'Insert a nickname';
                      },
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                    ElevatedButton(
                      child: (const Text('Sign up')),
                      onPressed: () => {
                        auth.signUp(email, password, nickname),
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
                      child: (const Text('Go to sign in')),
                      onPressed: () =>
                          Navigator.of(context).popAndPushNamed('login'),
                    )
                  ],
                ))));
  }
}
