import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_card_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_title_row_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/crypto_chart_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/segmented_time_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/upper_limit_text_widget.dart';
import 'package:crypto_lens/app/features/data/model/coins_model.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart'; // Bloc importu
import 'package:crypto_lens/app/features/presentation/home/bloc/home_state.dart'; // State importu
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Bloc kütüphanesi
import 'package:crypto_lens/app/common/constants/app_color.dart';

class BottomSheetWidget extends StatelessWidget {
  final CoinsModel coin;

  const BottomSheetWidget({super.key, required this.coin});

  static Future<void> show(BuildContext context, CoinsModel coin) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.midnightBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      isScrollControlled: true,
      // BottomSheet'in HomeBloc'a erişebilmesi için BlocProvider.value kullanıyoruz
      builder: (_) => BlocProvider.value(
        value: context.read<HomeBloc>(),
        child: BottomSheetWidget(coin: coin),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. ADIM: BlocBuilder ekledik, artık 'state' değişkenine erişebiliriz!
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        // Eğer API'den o coine özel yeni detay geldiyse onu, yoksa ilk halini kullan
        final currentCoin = state.coinDetail ?? coin;

        // Grafik verisini hazırla
        final List<FlSpot> chartData = currentCoin.sparkline
            .asMap()
            .entries
            .map((e) {
              return FlSpot(e.key.toDouble(), double.tryParse(e.value) ?? 0);
            })
            .toList();

        return SizedBox(
          height: context.height * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetTitleRowWidget(
                iconPath: currentCoin.iconUrl,
                name: currentCoin.name,
                symbol: currentCoin.symbol,
              ),
              const Divider(color: Colors.white10),

              // Veri yüklenirken küçük bir indikator gösterelim
              if (state.isBottomSheetLoading)
                const LinearProgressIndicator(
                  color: AppColor.neonBlue,
                  backgroundColor: Colors.transparent,
                ),

              AppTextWidget.big(
                "\$${double.tryParse(currentCoin.price)?.toStringAsFixed(2)}",
                color: AppColor.white,
              ),
              UpperLimitTextWidget(price: currentCoin.change),

              CryptoChartWidget(spots: chartData),

              SegmentedTimeWidget(
                uuid: currentCoin.uuid,
                // Artık 'state' tanımlı olduğu için hata vermeyecek!
                selectedPeriod: state.selectedTime ?? "7d",
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: BottomSheetCardWidget(coin: currentCoin),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
