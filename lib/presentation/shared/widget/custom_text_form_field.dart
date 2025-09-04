import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final String? labelText;
  final Function(String)? onChange;
  final String? errorMessage;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.onChange,
    this.labelText,
    this.errorMessage,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChange,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorMessage,
        ),
      ),
    );
  }
}
