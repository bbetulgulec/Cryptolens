import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildResponsiveIconWidget extends StatelessWidget {
  final String url;

  const BuildResponsiveIconWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.1,
      width: context.width * 0.1,
      child: url.toLowerCase().endsWith('.svg')
          ? SvgPicture.network(
              url,
              placeholderBuilder: (BuildContext context) => const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          : Image.network(
              url,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },
              errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
            ),
    );
  }

  Widget _buildPlaceholder() {
    return const Icon(Icons.currency_bitcoin, color: Colors.amber, size: 30);
  }
}
