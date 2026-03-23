import 'dart:async'; // Timer için gerekli
import 'package:crypto_lens/app/common/constants/app_color.dart';
import 'package:crypto_lens/app/common/widgets/app_text_widget.dart';
import 'package:crypto_lens/app/common/widgets/build_blurred_icon_widget.dart';
import 'package:crypto_lens/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class LimitReachedDialogWidget extends StatefulWidget {
  final int seconds;
  const LimitReachedDialogWidget({super.key, required this.seconds});

  @override
  State<LimitReachedDialogWidget> createState() =>
      _LimitReachedDialogWidgetState();
}

class _LimitReachedDialogWidgetState extends State<LimitReachedDialogWidget> {
  late int _currentSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.seconds; // Başlangıç değerini dışarıdan al
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds > 0) {
        setState(() {
          _currentSeconds--; // Her saniye bir azalt ve ekranı yenile
        });
      } else {
        _timer?.cancel(); // Süre bitince durdur
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Diyalog kapanınca timer'ı bellekten sil (Önemli!)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: AppColor.midnightBlue,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.05,
          vertical: context.height * 0.04,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BuildBlurredIconWidget(),
            const SizedBox(height: 24),
            AppTextWidget.big("Limit Reached", color: AppColor.white),
            const SizedBox(height: 12),
            AppTextWidget.regular(
              "The request limit has been reached. Please wait $_currentSeconds seconds.",
              color: AppColor.cloudyBlue,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            LinearProgressIndicator(
              value: _currentSeconds / widget.seconds,
              backgroundColor: Colors.white10,
              color: AppColor.modernViolet,
            ),
          ],
        ),
      ),
    );
  }
}
