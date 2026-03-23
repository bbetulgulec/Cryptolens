import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoinIconWidget extends StatelessWidget {
  final String? url;
  const CoinIconWidget({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty || !url!.startsWith('http')) {
      return _buildPlaceholder();
    }

    return SizedBox(
      width: context.width * 0.1,
      height: context.height * 0.1,
      child: url!.toLowerCase().endsWith('.svg')
          ? SvgPicture.network(
              url!,
              fit: BoxFit.contain,
              placeholderBuilder: (_) =>
                  const CircularProgressIndicator(strokeWidth: 2),
              errorBuilder: (_, _, _) => _buildPlaceholder(),
            )
          : Image.network(
              url!,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => _buildPlaceholder(),
            ),
    );
  }

  Widget _buildPlaceholder() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColor.white.withAlpha(10),
      child: const Icon(Icons.currency_bitcoin, color: AppColor.amber, size: 20),
    );
  }
}
