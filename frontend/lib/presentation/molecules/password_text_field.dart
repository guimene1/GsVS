import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'labeled_text_field.dart';

// Campo de senha com ícone de visibilidade
class PasswordTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;

  const PasswordTextField({
    super.key,
    this.label = 'Senha',
    this.hintText = 'Digite sua senha',
    this.controller,
    this.validator,
    this.onChanged,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.onSubmitted,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return LabeledTextField(
      label: widget.label,
      hintText: widget.hintText,
      prefixIcon: Icons.lock_outline_rounded,
      obscureText: _obscure,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onSubmitted: widget.onSubmitted,
      suffixIcon: GestureDetector(
        onTap: () => setState(() => _obscure = !_obscure),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Icon(
            _obscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.iconColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
