import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/constant_colors.dart';
import '../utils/extensions/extensions.dart';

class GlowingButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool filled;
  final EdgeInsets? padding;

  const GlowingButton({
    required this.text,
    required this.onPressed,
    this.filled = false,
    this.padding,
    super.key,
  });

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return MouseRegion(
      onEnter: (_) => isMobile ? null : setState(() => _isHovered = true),
      onExit: (_) => isMobile ? null : setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child:
            AnimatedContainer(
                  duration: 300.ms,
                  padding:
                      widget.padding ??
                      EdgeInsets.symmetric(
                        horizontal: isMobile ? 28 : 40,
                        vertical: isMobile ? 18 : 22,
                      ),
                  constraints: const BoxConstraints(minWidth: 180),
                  decoration: BoxDecoration(
                    gradient: widget.filled ? kButtonGradient : null,
                    color: widget.filled ? null : kTransparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: kAccentCyan.withAlpha(widget.filled ? 230 : 140),
                      width: 2.5,
                    ),
                    boxShadow: _isHovered || _isPressed
                        ? [
                            BoxShadow(
                              color: kAccentCyan.withAlpha(
                                _isPressed ? 180 : 160,
                              ),
                              blurRadius: _isPressed ? 20 : 35,
                              spreadRadius: _isPressed ? 2 : 4,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: kAccentCyan.withAlpha(
                                _isPressed ? 120 : 100,
                              ),
                              blurRadius: 60,
                              spreadRadius: 10,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: kAccentCyan.withAlpha(80),
                              blurRadius: 20,
                              spreadRadius: 0,
                            ),
                          ],
                  ),
                  child: SelectableText(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 17 : 18,
                      fontWeight: semiBold,
                      color: kWhite,
                      letterSpacing: 0.5,
                      shadows: widget.filled
                          ? [
                              Shadow(
                                color: kBlack.withValues(alpha: 0.3),
                                offset: const Offset(0, 1),
                                blurRadius: 4,
                              ),
                            ]
                          : null,
                    ),
                  ),
                )
                .animate(target: (_isHovered || _isPressed) ? 1 : 0)
                .scale(
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.06, 1.06),
                  curve: Curves.easeOutCubic,
                )
                .elevation(begin: 8, end: 30, curve: Curves.easeOutCubic)
                .then(delay: 500.ms)
                .shimmer(
                  duration: 3200.ms,
                  color: widget.filled
                      ? kWhite.withValues(alpha: 0.25)
                      : kTransparent,
                ),
      ),
    );
  }
}
