
import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class SearchBarRowWidget extends StatelessWidget {
  const SearchBarRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            hintText: "Search Assets",
            backgroundColor: WidgetStatePropertyAll(AppColor.cloudyBlue),
          ),
        ),
        SizedBox(width: context.width * 0.07),
        Icon(Icons.tune, color: AppColor.cloudyBlue),
      ],
    );
  }
}
