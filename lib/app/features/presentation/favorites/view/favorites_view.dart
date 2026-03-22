import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:crypto_lens/app/features/presentation/favorites/widget/assets_card_widget.dart';
import 'package:crypto_lens/app/common/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.big("Favorites", color: AppColor.white),
          AssetsCardWidget(onTap: () => BottomSheetWidget.show(context)),
        ],
      ).symmetricPadding(horizontal: context.width * 0.03),
    );
  }
}
