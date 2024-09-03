import "package:flutter/material.dart";

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String Function(String?)? validator;
  final InputDecoration? decoration;

  final String placeholder;
  final Widget visibleIcon;
  final Widget hiddenIcon;

  const PasswordTextField({
    required this.controller,
    this.validator,
    this.decoration,
    this.placeholder = "Password...",
    this.visibleIcon = const Icon(Icons.visibility_outlined),
    this.hiddenIcon = const Icon(Icons.visibility_off_outlined),
    super.key,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_isPasswordVisible,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: _isPasswordVisible ? widget.visibleIcon : widget.hiddenIcon,
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
    );
  }
}
