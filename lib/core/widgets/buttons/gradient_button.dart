import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/constant_colors.dart';
import '../../utils/extensions/extensions.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color> gradientColors;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradientColors = const [Color(0xFFFFF59D), Color(0xFFFF6F00)],
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        _shimmerController.forward();
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        _shimmerController.stop();
        _shimmerController.reset();
      },
      child: AnimatedScale(
        scale: _isHovering ? 1.06 : 1.0,
        duration: 250.ms,
        curve: Curves.easeOutBack,
        child: AnimatedBuilder(
          animation: _shimmerController,
          builder: (context, child) {
            final shimmerPos = _shimmerController.value * 2 - 1;

            return ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 10,
                backgroundColor: Colors.transparent,
                shadowColor: widget.gradientColors.last.withValues(alpha: 0.5),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: widget.gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isHovering)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                colors: [
                                  kWhite.withValues(alpha: 0.0),
                                  kWhite.withValues(alpha: 0.28),
                                  kWhite.withValues(alpha: 0.0),
                                ],
                                stops: const [0.2, 0.5, 0.8],
                                begin: Alignment(-1 + shimmerPos, 0),
                                end: Alignment(1 + shimmerPos, 0),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Button text + icon
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 28 : 36,
                        vertical: isMobile ? 16 : 20,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.text,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 16 : 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          AnimatedContainer(
                            duration: 250.ms,
                            transform: Matrix4.translationValues(
                              _isHovering ? 5 : 0,
                              0,
                              0,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ).animate().scaleXY(
      delay: 500.ms,
      duration: 400.ms,
      curve: Curves.easeOutBack,
      begin: 0.8,
      end: 1.0,
    );
  }
}
