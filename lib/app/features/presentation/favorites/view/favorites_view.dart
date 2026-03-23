import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/get_it/get_it.dart';
import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_event.dart';
import 'package:crypto_lens/app/features/presentation/favorites/bloc/favorites_state.dart';
import 'package:crypto_lens/app/features/presentation/home/widget/assets_card_widget.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => getIt<FavoritesBloc>()..add(const FetchHomeData()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextWidget.big("Favorites", color: AppColor.white),
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

                        // favorites_view.dart içindeki onTap:
                        onTap: () {
                          // 1. HomeBloc'u uyar ki BottomSheet içindeki BlocBuilder tetiklensin

                          // 2. FavoritesBloc'u uyar ki kendi state'ini güncellesin (opsiyonel ama tutarlılık için iyi)
                          context.read<FavoritesBloc>().add(
                            FetchCoinDetail(uuid: coin.uuid, time: "7d"),
                          );

                          // 3. BottomSheet'i aç
                          BottomSheetWidget.show(context, coin);
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
      ),
    );
  }
}
