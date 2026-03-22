import 'package:crypto_lens/app/common/get_it/get_it.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_event.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_state.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/assets_card_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/search_bar_row_widget.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/text_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // 1. ADIM: Metodu buraya, build'in dışına tanımlıyoruz
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
      child: BlocProvider<HomeBloc>(
        create: (context) => getIt<HomeBloc>()..add(const FetchHomeData()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              // Bir hata oluşursa kullanıcıya göster
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading && state.coins.isEmpty) {
              return const Center(child: CircularProgressIndicator());
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
                          context.read<HomeBloc>().add(
                            FetchCoinDetail(uuid: coin.uuid, time: "7d"),
                          );
                          BottomSheetWidget.show(context, coin);
                        },
                        onFavoriteTap: () {
                          // BLOC'A FAVORİ EVENT'İNİ GÖNDER
                          context.read<HomeBloc>().add(
                            ToggleFavorite(uuid: coin.uuid),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
