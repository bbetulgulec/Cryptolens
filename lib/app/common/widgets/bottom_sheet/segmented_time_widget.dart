import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_event.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SegmentedTimeWidget extends StatelessWidget {
  final String selectedPeriod;
  final String uuid; // Hangi coin olduğunu bilmemiz şart

  const SegmentedTimeWidget({
    super.key,
    required this.selectedPeriod, // State'den gelecek (örn: "24h")
    required this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    // API'nin anladığı gerçek değerleri bir Map'te tutalım
    final Map<String, String> periods = {
      "12H": "12h",
      "24H": "24h",
      "7D": "7d",
      "30D": "30d",
      "1Y": "1y",
      "5Y": "5y",
    };

    return Container(
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: periods.entries.map((entry) {
          // entry.key = "24H" (Görünen), entry.value = "24h" (API'ye giden)
          return _buildButton(context, entry.key, entry.value);
        }).toList(),
      ),
    ).allPadding(context.height * 0.02);
  }

  Widget _buildButton(BuildContext context, String title, String apiValue) {
    // Eğer state'deki selectedPeriod ile bu butonun apiValue'su aynıysa "seçili" göster
    final bool isSelected = selectedPeriod == apiValue;

    return GestureDetector(
      onTap: () {
        // TIKLAMA BURADA: Bloc'a yeni veriyi getir diyoruz
        context.read<HomeBloc>().add(
          FetchCoinDetail(uuid: uuid, time: apiValue),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.neonBlue.withAlpha(60)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColor.electricBlue : AppColor.skyBlue,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ).allPadding(context.height * 0.01),
      ),
    );
  }
}
