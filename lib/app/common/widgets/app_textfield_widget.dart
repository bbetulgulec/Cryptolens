import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  AppTextFieldWidget({
    super.key,
    required this.text,
    this.onChanged,
    this.isPassword = false,
  });
  final Function(String)? onChanged;
  final String text;
  final bool isPassword;

  final ValueNotifier<bool> _obscureNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureNotifier,
      builder: (context, obscure, _) {
        return TextField(
          onChanged: onChanged,
          obscureText: isPassword ? obscure : false,
          style: const TextStyle(color: AppColor.white),
          decoration: InputDecoration(
            labelText: text,
            labelStyle: const TextStyle(color: AppColor.white),
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.white, width: 2),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColor.white,
                    ),
                    onPressed: () => _obscureNotifier.value = !obscure,
                  )
                : null,
          ),
        );
      },
    );
  }
}
