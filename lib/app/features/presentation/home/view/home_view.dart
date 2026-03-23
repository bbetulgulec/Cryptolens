import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_event.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_state.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/assets_card_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/search_bar_row_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/text_row_widget.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  String formatVolume(String? volume) {
    if (volume == null) return "24h Vol: \$0";
    double val = double.tryParse(volume) ?? 0;
    if (val >= 1e12) return "24h Vol: \$${(val / 1e12).toStringAsFixed(2)}T";
    if (val >= 1e9) return "24h Vol: \$${(val / 1e9).toStringAsFixed(2)}B";
    if (val >= 1e6) return "24h Vol: \$${(val / 1e6).toStringAsFixed(2)}M";
    return "24h Vol: \$${val.toStringAsFixed(0)}";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppColor.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.coins.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.neonBlue,
                strokeWidth: 2,
              ),
            );
          }
          final coinsToShow = state.searchQuery.isEmpty
              ? state.coins
              : state.filteredCoins;
          return Column(
            children: [
              SearchBarRowWidget(
                onChanged: (String value) {
                  context.read<HomeBloc>().add(SearchCoins(value));
                },
              ),
              TextRowWidget(
                total24hVolume: formatVolume(state.stats?.total24hVolume),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: coinsToShow.length,
                  itemBuilder: (context, index) {
                    final coin = coinsToShow[index];
                    return AssetsCardWidget(
                      url: coin.iconUrl,
                      name: coin.name,
                      nameAbb: coin.symbol,
                      dolarText: "\$${coin.price}",
                      ratio: "${coin.change}%",
                      isFavorite: state.favoriteUuids.contains(coin.uuid),
                      onTap: () {
                        // 1. Detayı çekmesi için event'i fırlat
                        context.read<HomeBloc>().add(
                          FetchCoinDetail(uuid: coin.uuid, time: "7d"),
                        );

                        // 2. Saf Widget'ı sayfanın kendi Bloc'uyla sarmalayarak aç
                        BottomSheetWidget.show(
                          context,
                          child: BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              return BottomSheetWidget(
                                coin: state.coinDetail ?? coin,
                                isLoading: state.isBottomSheetLoading,
                                selectedTime: state.selectedTime ?? "7d",
                                onTimeChanged: (newTime) {
                                  context.read<HomeBloc>().add(
                                    FetchCoinDetail(
                                      uuid: coin.uuid,
                                      time: newTime,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                      onFavoriteTap: () {
                        context.read<HomeBloc>().add(
                          ToggleFavorite(uuid: coin.uuid),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ).symmetricPadding(horizontal: context.width * 0.0);
        },
      ),
    );
  }
}
