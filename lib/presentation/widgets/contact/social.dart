//lib/presentation/widgets/contact/social.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_data.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../models/social_link.dart';

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visibilityKey: 'social-row',
      delay: 600.ms,
      child: Wrap(
        spacing: 28,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: socialLinks
            .map((link) => _SocialButton(social: link))
            .toList(),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final SocialLink social;
  const _SocialButton({required this.social});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final Color hoverColor = widget.social.brandColor ?? kAccentCyan;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => launchUrl(Uri.parse(widget.social.url)),
        child:
            AnimatedContainer(
                  duration: 300.ms,
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _hover ? hoverColor : kWhite24,
                      width: 2,
                    ),
                    color: _hover
                        ? hoverColor.withValues(alpha: 0.12)
                        : kTransparent,
                    boxShadow: _hover
                        ? [
                            BoxShadow(
                              color: hoverColor.withValues(alpha: 0.4),
                              blurRadius: 20,
                            ),
                          ]
                        : null,
                  ),
                  child: FaIcon(
                    widget.social.icon,
                    size: 26,
                    color: _hover ? hoverColor : kTextSecondary,
                  ),
                )
                .animate(target: _hover ? 1 : 0)
                .scale(
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.25, 1.25),
                  duration: 300.ms,
                  curve: Curves.easeOutBack,
                )
                .shimmer(
                  duration: 2000.ms,
                  color: hoverColor.withValues(alpha: 0.3),
                ),
      ),
    );
  }
}
