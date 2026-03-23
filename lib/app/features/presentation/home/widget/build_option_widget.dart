import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:flutter/material.dart';

class BuildOptionWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final IconData icon;
  final VoidCallback onTap;

  const BuildOptionWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isSelected ? AppColor.neonBlue : Colors.white60,
      ),
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.white : Colors.white70),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColor.neonBlue)
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
