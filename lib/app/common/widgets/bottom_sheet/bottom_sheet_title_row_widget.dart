import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomSheetTitleRowWidget extends StatelessWidget {
  final String iconPath;
  final String name;
  final String symbol;

  const BottomSheetTitleRowWidget({
    super.key,
    required this.iconPath,
    required this.name,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildResponsiveIcon(context, iconPath),
        RichText(
          text: TextSpan(
            text: name,
            style: const TextStyle(color: AppColor.white, fontSize: 30),
            children: <TextSpan>[
              TextSpan(
                text: symbol,
                style: const TextStyle(
                  color: AppColor.skyBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ).symmetricPadding(
      horizontal: context.width * 0.01,
      vertical: context.height * 0.02,
    );
  }

  Widget _buildResponsiveIcon(BuildContext context, String url) {
    return SizedBox(
      height: 45, // Boyutu biraz büyüttük, başlık kısmı olduğu için
      width: 45,
      child: url.toLowerCase().endsWith('.svg')
          ? SvgPicture.network(
              url,
              placeholderBuilder: (_) =>
                  const CircularProgressIndicator(strokeWidth: 2),
              errorBuilder: (_, _, _) => _buildPlaceholder(),
            )
          : Image.network(
              url,
              loadingBuilder: (_, child, progress) => progress == null
                  ? child
                  : const CircularProgressIndicator(strokeWidth: 2),
              errorBuilder: (_, _, _) => _buildPlaceholder(),
            ),
    );
  }

  Widget _buildPlaceholder() {
    return const Icon(Icons.currency_bitcoin, color: Colors.amber, size: 30);
  }
}
