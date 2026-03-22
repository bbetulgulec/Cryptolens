import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {

  const AppTextField({super.key, required this.text, this.onChanged});
final Function(String)? onChanged; 
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: text,
        filled: true,
        fillColor: AppColor.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
