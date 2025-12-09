import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedImage extends StatefulWidget {
  final Widget child;
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
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    if (!_hasAppeared) {
      setState(() => _hasAppeared = true);
      if (mounted) _controller.forward();
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
      child: widget.child
          .animate(controller: _controller, autoPlay: false)
          .fade(
            begin: 0.0,
            end: 1.0,
            delay: 500.ms,
            duration: 1000.ms,
            curve: Curves.easeOut,
          )
          .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
            delay: 500.ms,
            duration: 1000.ms,
            curve: Curves.easeOutQuart,
          )
          .blur(
            begin: const Offset(20, 20),
            end: const Offset(0, 0),
            delay: 700.ms,
            duration: 2000.ms,
            curve: Curves.easeOutCubic,
          )
          .then(delay: 1000.ms)
          .scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.02, 1.02),
            duration: 150.ms,
            curve: Curves.easeOut,
          )
          .then()
          .scale(
            begin: const Offset(1.02, 1.02),
            end: const Offset(1.0, 1.0),
            duration: 150.ms,
            curve: Curves.easeIn,
          ),
    );
  }
}
