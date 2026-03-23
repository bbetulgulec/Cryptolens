import 'package:crypto_lens/app/common/widgets/limit_reached_dialog_widget.dart';
import 'package:crypto_lens/core/helpers/navigation_helper/navigation_helper.dart';
import 'package:flutter/material.dart';

class DialogService {
  static bool _isDialogOpen = false; // Aynı anda birden fazla diyalog açılmasın

  static void showRateLimitDialog(int seconds) {
    final context = Navigation.navigationKey.currentContext;
    if (context == null || _isDialogOpen) return;

    _isDialogOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        // Geri tuşuyla kapatılmasını engelle
        canPop: false,
        child: LimitReachedDialogWidget(seconds: seconds),
      ),
    );
  }

  static void closeDialog() {
    final context = Navigation.navigationKey.currentContext;
    if (context != null && _isDialogOpen) {
      Navigator.of(context, rootNavigator: true).pop();
      _isDialogOpen = false;
    }
  }
}
