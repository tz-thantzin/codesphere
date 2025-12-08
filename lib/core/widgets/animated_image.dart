import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedImage extends StatefulWidget {
  final Widget child; // image or any widget
  final String visibilityKey;
  final double visibleFraction;

  const AnimatedImage({
    super.key,
    required this.child,
    required this.visibilityKey,
    this.visibleFraction = 0.3,
  });

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _hasAppeared = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    if (!_hasAppeared) {
      setState(() => _hasAppeared = true);
      Future.delayed(1000.ms, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.visibilityKey),
      onVisibilityChanged: (VisibilityInfo info) {
        if (!_hasAppeared && info.visibleFraction > widget.visibleFraction) {
          _triggerAnimation();
        }
      },
      child: _buildAnimatedChild(),
    );
  }

  Widget _buildAnimatedChild() {
    return widget.child
        .animate(controller: _controller)
        .then(delay: 800.ms)
        .scale(
          begin: const Offset(0.6, 0.6),
          end: const Offset(1.0, 1.0),
          delay: 1200.ms,
          duration: 1200.ms,
          curve: Curves.easeOutQuart,
        )
        .fade(
          begin: 0.0,
          end: 1.0,
          delay: 1200.ms,
          duration: 1500.ms,
          curve: Curves.easeOut,
        )
        .blur(
          begin: const Offset(22, 22),
          end: const Offset(0, 0),
          delay: 1200.ms,
          duration: 1800.ms,
          curve: Curves.easeOutCubic,
        )
        .move(
          begin: const Offset(0, 14),
          end: Offset.zero,
          delay: 1200.ms,
          duration: 1300.ms,
          curve: Curves.easeOut,
        )
        .then(delay: 500.ms)
        .scale(
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.02, 1.02),
          duration: 160.ms,
          curve: Curves.easeOut,
        );
  }
}
