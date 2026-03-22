import 'package:flutter/material.dart';
import 'package:crypto_lens/app/common/constants/app_color.dart'; // Renklerin olduğu yer

class FilterBottomSheetWidget extends StatelessWidget {
  const FilterBottomSheetWidget({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.midnightBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => const FilterBottomSheetWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Sort By",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.white10),
          
          // Seçenekleri buraya diziyoruz
          _buildOption(context, "Price", Icons.attach_money),
          _buildOption(context, "Market Cap", Icons.pie_chart),
          _buildOption(context, "24h Volume", Icons.bar_chart),
          _buildOption(context, "Change (%)", Icons.trending_up),
          
          const SizedBox(height: 30), // Alt boşluk
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColor.neonBlue),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        // İleride buraya BLoC event'i gelecek
        Navigator.pop(context);
      },
    );
  }
}