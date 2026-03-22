import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:flutter/material.dart';

class BottomSheetCardWidget extends StatelessWidget {
  const BottomSheetCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero, 
      shrinkWrap: true, 
      physics:
          const NeverScrollableScrollPhysics(), 
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.8,
      children: [
        _buildInfoCard("RANK", "#1"),
        _buildInfoCard("MARKET CAP", "\$1.2T"),
        _buildInfoCard("24H VOL", "\$4.2B"),
        _buildInfoCard("HIGH/LOW", "\$66k / \$64k"),
      ],
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.cloudyBlue.withAlpha(60)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.regular(title, color: AppColor.skyBlue),
          const SizedBox(height: 4),
          AppText.bold(value, color: AppColor.white),
        ],
      ),
    );
  }
}
