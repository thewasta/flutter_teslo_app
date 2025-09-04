import 'package:flutter/material.dart';
import 'package:teslo_app/presentation/shared/widget/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 80, width: double.infinity),
                  Text(
                    "App",
                    style: textStyle.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Login to your account",
                        style: textStyle.titleSmall,
                      ),
                      const CustomTextFormField(
                        hintText: "Email",
                        labelText: "Email",
                        errorMessage: "Esto es un ejemplo",
                      ),
                      const CustomTextFormField(
                        hintText: "Password",
                        labelText: "Password",
                        obscureText: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: FilledButton(
                              onPressed: null,
                              child: Text(
                                "Sign in",
                                style: textStyle.headlineSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
