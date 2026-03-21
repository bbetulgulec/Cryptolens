import 'package:crypto_lens/app/common/enum/app_image.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String titleDesc;
  final String emailText;
  final String passwordText;
  const AppCard({
    super.key,
    required this.title,
    required this.titleDesc,
    required this.emailText,
    required this.passwordText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Image.asset(AppImage.appIcon.path, fit: BoxFit.cover),
          Text(title),
          Text(titleDesc),
          TextField(
            decoration: InputDecoration(
              labelText: emailText,
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: passwordText,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
