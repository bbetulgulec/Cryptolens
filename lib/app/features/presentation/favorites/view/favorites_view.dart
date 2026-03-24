import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/constants/app_strings.dart';
import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_event.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_state.dart';
import 'package:crypto_lens/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/assets_card_widget.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Home sayfasındaki güncel coin listesini alıyoruz
    final allHomeCoins = context.read<HomeBloc>().state.coins;

    // 2. FavoritesBloc'a bu listeyi verip "kendini buna göre güncelle" diyoruz
    context.read<FavoritesBloc>().add(SyncWithHome(allHomeCoins));
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWidget.big(AppStrings.favorites, color: AppColor.white),
          Expanded(
            child: BlocBuilder<FavoritesBloc, FavoriteState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: state.coins.length,
                  itemBuilder: (context, index) {
                    final coin = state.coins[index];
                    return AssetsCardWidget(
                      url: coin.iconUrl,

                      onTap: () {
                        final favBloc = context.read<FavoritesBloc>();

                        // İlk açılış verisini iste
                        favBloc.add(
                          FetchFavoriteCoinDetail(uuid: coin.uuid, time: "7d"),
                        );

                        BottomSheetWidget.show(
                          context,
                          child: BlocBuilder<FavoritesBloc, FavoriteState>(
                            builder: (context, state) {
                              return BottomSheetWidget(
                                coin: state.coinDetail ?? coin,
                                isLoading: state.isLoading,
                                selectedTime: state
                                    .selectedTime, // State'ten gelen seçili zamanı basar
                                onTimeChanged: (newTime) {
                                  // İŞTE BURASI: Butona basınca bu bloc tetiklenecek!
                                  favBloc.add(
                                    FetchFavoriteCoinDetail(
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
                      name: coin.name,
                      nameAbb: coin.symbol,
                      dolarText:
                          "\$${double.tryParse(coin.price)?.toStringAsFixed(2) ?? coin.price}",
                      ratio: "${coin.change}%",
                      isFavorite: true,
                      onFavoriteTap: () {
                        context.read<FavoritesBloc>().add(
                          ToggleFavorite(uuid: coin.uuid),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ).symmetricPadding(horizontal: context.width * 0.03),
    );
  }
}
