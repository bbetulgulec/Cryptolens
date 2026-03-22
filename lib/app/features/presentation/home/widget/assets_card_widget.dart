import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:crypto_lens/core/extensions/widgets/padding_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetsCardWidget extends StatelessWidget {
  final String? url;
  final String name;
  final String nameAbb;
  final String dolarText;
  final String ratio;

  const AssetsCardWidget({
    super.key,
    this.url,
    required this.name,
    required this.nameAbb,
    required this.dolarText,
    required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    final Color ratioColor = ratio.startsWith('-') ? Colors.red : Colors.green;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: AppColor.midnightBlue,
      elevation: 4,
      child: Row(
        children: [
          _buildCoinIcon(),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.medium(name, color: AppColor.white),
                AppText.regular(
                  nameAbb,
                  color: AppColor.white.withOpacity(0.6),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.medium(dolarText, color: AppColor.white),
                AppText.regular(ratio, color: ratioColor),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.star_border, color: AppColor.white, size: 20),
        ],
      ).allPadding(context.height * 0.015),
    );
  }

  Widget _buildCoinIcon() {
  // 1. Temel Kontrol
  if (url == null || url!.isEmpty || !url!.startsWith('http')) {
    return _buildPlaceholder();
  }

  return SizedBox(
    width: 40,
    height: 40,
    child: _buildImageByExtension(url!),
  );
}

Widget _buildImageByExtension(String imageUrl) {
  // URL'nin sonu .svg ile mi bitiyor? (Küçük harfe çevirerek kontrol et)
  if (imageUrl.toLowerCase().endsWith('.svg')) {
    return SvgPicture.network(
      imageUrl,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => const CircularProgressIndicator(strokeWidth: 2),
      // SVG bozuksa veya XML hatası verirse buraya düşer
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
    );
  } else {
    // .png, .jpg veya diğer formatlar için normal Image widget'ı
    return Image.network(
      imageUrl,
      fit: BoxFit.contain,
      // Resim yüklenirken
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const CircularProgressIndicator(strokeWidth: 2);
      },
      // PNG bozuksa veya yüklenemezse buraya düşer
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
    );
  }
}

  Widget _buildPlaceholder() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.white.withOpacity(0.1),
      child: const Icon(Icons.currency_bitcoin, color: Colors.amber, size: 20),
    );
  }
}
