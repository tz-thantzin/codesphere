// lib/presentation/widgets/footer_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/constants/constant_data.dart';
import '../../core/constants/constant_sizes.dart';
import '../../core/utils/extensions/extensions.dart';
import '../../core/widgets/animated_fade_slide.dart';
import '../../core/widgets/typography.dart';
import '../../models/social_link.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return AnimatedFadeSlide(
      visibilityKey: 'footer',
      delay: 100.ms,
      beginY: 0.15,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.adaptive(90, 120),
          horizontal: 32,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: kAccentCyan.withValues(alpha: 0.25),
              width: 1.5,
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kAccentCyan.withValues(alpha: 0.08), kTransparent],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isMobile ? const _MobileLayout() : const _DesktopLayout(),
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();
  @override
  Widget build(BuildContext context) => const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [_Logo(), _Copyright(), _SocialIcons()],
  );
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();
  @override
  Widget build(BuildContext context) => const Column(
    children: [
      _Logo(),
      SizedBox(height: 32),
      _Copyright(),
      SizedBox(height: 48),
      _SocialIcons(),
    ],
  );
}

// LOGO
class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return GradientText(
      context.localization.codesphere,
      textAlign: TextAlign.center,
      fontSize: context.adaptive(ts28, ts48),
      gradient: kButtonGradient,
      shimmer: true,
    );
  }
}

// COPYRIGHT
class _Copyright extends StatelessWidget {
  const _Copyright();

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: "${context.localization.footer_copyright} ",
        style: const TextStyle(color: kTextSecondary, height: 1.7),
        children: [
          TextSpan(
            text: context.localization.footer_rights_reserved,
            style: const TextStyle(fontWeight: bold),
          ),
          const TextSpan(text: "\n"),
          TextSpan(
            text: context.localization.footer_tagline,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

// SOCIAL ICONS
class _SocialIcons extends StatelessWidget {
  const _SocialIcons();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 28,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: socialLinks.map((link) => _SocialButton(social: link)).toList(),
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
    final Color glow = widget.social.brandColor ?? kAccentCyan;

    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => launchUrl(Uri.parse(widget.social.url)),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child:
            AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _hover ? glow : kWhite24,
                      width: 2,
                    ),
                    color: _hover ? glow.withValues(alpha: 0.12) : kTransparent,
                    boxShadow: _hover
                        ? [
                            BoxShadow(
                              color: glow.withValues(alpha: 0.45),
                              blurRadius: 24,
                              spreadRadius: 6,
                            ),
                          ]
                        : null,
                  ),
                  child: FaIcon(
                    widget.social.icon,
                    size: 24,
                    color: _hover ? glow : kTextSecondary,
                  ),
                )
                .animate(target: _hover ? 1 : 0)
                .scaleXY(begin: 1.0, end: 1.28, duration: 350.ms)
                .shimmer(
                  duration: 2200.ms,
                  color: glow.withValues(alpha: 0.35),
                ),
      ),
    );
  }
}
