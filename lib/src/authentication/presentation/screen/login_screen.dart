import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/src/authentication/presentation/provider/authentication_provider.dart';
import 'package:teslo_app/src/authentication/presentation/provider/login_form_provider.dart';
import 'package:teslo_app/src/shared/presentation/presentation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(body: _LoginView()),
    );
  }
}

class _LoginView extends ConsumerWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final form = ref.watch(loginFormProvider);

    ref.listen(authenticationProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(next.errorMessage)));
    });
    return SafeArea(
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
                  Text("Login to your account", style: textStyle.titleSmall),
                  CustomTextFormField(
                    hintText: "Email",
                    labelText: "Email",
                    onChange:
                        ref.read(loginFormProvider.notifier).onEmailChanged,
                    errorMessage:
                        form.hasBeenPosted ? form.email.errorMessage : null,
                  ),
                  CustomTextFormField(
                    hintText: "Password",
                    labelText: "Password",
                    obscureText: true,
                    onChange:
                        ref.read(loginFormProvider.notifier).onPasswordChanged,
                    errorMessage:
                        form.hasBeenPosted ? form.password.errorMessage : null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: FilledButton(
                          onPressed:
                              ref.read(loginFormProvider.notifier).onSubmit,
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
    );
  }
}
