// lib/core/widgets/glowing_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/constant_colors.dart';
import '../utils/extensions/extensions.dart';

class GlowingButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool filled;
  final EdgeInsets? padding;
  final double? fontSize;

  const GlowingButton({
    super.key,
    required this.text,
    this.onPressed,
    this.filled = false,
    this.padding,
    this.fontSize,
  });

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool disabled = widget.onPressed == null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: disabled ? null : (_) => setState(() => _isPressed = true),
        onTapUp: disabled
            ? null
            : (_) {
                setState(() => _isPressed = false);
                widget.onPressed?.call();
              },
        onTapCancel: disabled ? null : () => setState(() => _isPressed = false),
        child:
            AnimatedContainer(
                  duration: 400.ms,
                  curve: Curves.easeOutCubic,
                  padding:
                      widget.padding ??
                      EdgeInsets.symmetric(
                        horizontal: context.adaptive(36, 64),
                        vertical: context.adaptive(20, 28),
                      ),
                  constraints: BoxConstraints(
                    minWidth: context.adaptive(180, 240),
                  ),
                  decoration: BoxDecoration(
                    gradient: widget.filled ? kButtonGradient : null,
                    color: widget.filled ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(
                      context.adaptive(18, 24),
                    ),
                    border: Border.all(
                      color: kAccentCyan.withAlpha(widget.filled ? 240 : 160),
                      width: context.adaptive(2.2, 3.0),
                    ),
                    boxShadow: _buildBoxShadow(),
                  ),
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: widget.fontSize ?? context.adaptive(15, 20),
                      fontWeight: FontWeight.w800,
                      color: kWhite,
                      letterSpacing: context.adaptive(0.6, 1.2),
                      height: 1.2,
                      shadows: widget.filled
                          ? [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.4),
                                offset: const Offset(0, 2),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                  ),
                )
                // Glow Intensity
                .animate(target: _isHovered && !disabled ? 1 : 0)
                .shimmer(
                  duration: 2800.ms,
                  color: widget.filled
                      ? Colors.white.withValues(alpha: 0.3)
                      : kAccentCyan.withValues(alpha: 0.15),
                )
                // Hover + Press Scale
                .animate(
                  target: (_isHovered || _isPressed) && !disabled ? 1 : 0,
                )
                .scale(
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.07, 1.07),
                  curve: Curves.easeOutBack,
                  duration: 400.ms,
                ),
      ),
    );
  }

  List<BoxShadow> _buildBoxShadow() {
    if (_isPressed) {
      return [
        BoxShadow(
          color: kAccentCyan.withValues(alpha: 0.4),
          blurRadius: 30,
          spreadRadius: 6,
          offset: const Offset(0, 12),
        ),
        BoxShadow(
          color: kAccentCyan.withValues(alpha: 0.25),
          blurRadius: 80,
          spreadRadius: 20,
        ),
      ];
    }

    if (_isHovered) {
      return [
        BoxShadow(
          color: kAccentCyan.withValues(alpha: 0.35),
          blurRadius: 40,
          spreadRadius: 8,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: kAccentCyan.withValues(alpha: 0.2),
          blurRadius: 100,
          spreadRadius: 15,
        ),
      ];
    }

    return [
      BoxShadow(
        color: kAccentCyan.withValues(alpha: 0.15),
        blurRadius: 25,
        spreadRadius: 0,
        offset: const Offset(0, 8),
      ),
    ];
  }
}
