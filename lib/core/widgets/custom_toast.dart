// lib/core/widgets/custom_toast.dart
import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/constant_colors.dart';

class CustomToast {
  CustomToast._();
  static final CustomToast instance = CustomToast._();

  OverlayEntry? _currentEntry;
  Timer? _timer;

  void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 5),
  }) {
    _removeCurrent();

    final overlay = Overlay.of(context);
    final size = MediaQuery.sizeOf(context);

    // Responsive width
    final maxWidth = size.width * 0.35;
    final toastWidth = size.width < 600 ? 350.0 : maxWidth.clamp(300.0, 500.0);

    _currentEntry = OverlayEntry(
      builder: (_) => _ToastWidget(
        message: message,
        isError: isError,
        width: toastWidth,
        onClose: _removeCurrent,
      ),
    );

    overlay.insert(_currentEntry!);

    // Auto-dismiss
    _timer = Timer(duration, _removeCurrent);
  }

  /// Force dismiss current toast
  void dismiss() => _removeCurrent();

  void _removeCurrent() {
    _timer?.cancel();
    _timer = null;
    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _ToastWidget extends StatelessWidget {
  final String message;
  final bool isError;
  final double width;
  final VoidCallback onClose;

  const _ToastWidget({
    required this.message,
    required this.isError,
    required this.width,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              color: isError ? kRed100 : kGreen,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onClose,
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
