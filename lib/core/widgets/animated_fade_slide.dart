import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedFadeSlide extends StatefulWidget {
  final Widget child;
  final String visibilityKey;
  final double visibleFraction;
  final Duration delay;
  final double beginY;
  final Curve curve;
  final VisibilityChangedCallback? onVisibilityChanged;

  const AnimatedFadeSlide({
    super.key,
    required this.child,
    required this.visibilityKey,
    this.visibleFraction = 0.3,
    this.delay = Duration.zero,
    this.beginY = 0.3,
    this.curve = Curves.easeOutCubic,
    this.onVisibilityChanged,
  });

  @override
  State<AnimatedFadeSlide> createState() => _AnimatedFadeSlideState();
}

class _AnimatedFadeSlideState extends State<AnimatedFadeSlide> {
  bool _hasAppeared = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.visibilityKey),
      onVisibilityChanged: (VisibilityInfo info) {
        // Trigger animation once when 30%+ visible
        if (!_hasAppeared && info.visibleFraction > widget.visibleFraction) {
          if (mounted) {
            setState(() => _hasAppeared = true);
          }
        }

        widget.onVisibilityChanged?.call(info);
      },
      child: AnimatedOpacity(
        opacity: _hasAppeared ? 1.0 : 0.0,
        duration: 900.ms,
        curve: widget.curve,
        child: AnimatedSlide(
          offset: _hasAppeared ? Offset.zero : Offset(0, widget.beginY),
          duration: 1000.ms + widget.delay,
          curve: widget.curve,
          child: widget.child,
        ),
      ),
    );
  }
}
