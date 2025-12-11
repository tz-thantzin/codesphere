import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/constant_colors.dart';
import '../../core/constants/constant_sizes.dart';
import '../../core/utils/extensions/extensions.dart';
import '../../core/widgets/animated_fade_slide.dart';
import '../../core/widgets/typography.dart';

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
        padding: context.defaultPagePadding(),
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
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_Logo(), _Copyright(), _ContactInfo()],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _Logo(),
        SizedBox(height: s40),
        _ContactInfo(),
        SizedBox(height: s32),
        _Copyright(),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return GradientText(
      context.localization.codesphere,
      textAlign: TextAlign.center,
      fontSize: context.adaptive(ts28, ts48),
      fontFamily: GoogleFonts.saira().fontFamily,
      gradient: kButtonGradient,
      shimmer: true,
    );
  }
}

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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: "\n"),
          TextSpan(
            text: context.localization.footer_tagline,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: context.adaptive(ts14, ts15)),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSmall(
          "Contact & Location",
          color: kAccentCyan,
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),

        const SizedBox(height: s24),

        const _ContactRow(
          icon: Icons.location_on_outlined,
          text: "Yangon, Myanmar & Bangkok, Thailand",
        ),

        const SizedBox(height: s16),

        _ContactRow(
          icon: Icons.phone_outlined,
          text: "+959 751 864 449 (Viber)",
          onTap: () => launchUrl(Uri.parse("tel:+959751864449")),
        ),
      ],
    );
  }
}

class _ContactRow extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const _ContactRow({required this.icon, required this.text, this.onTap});

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final bool isClickable = widget.onTap != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: isClickable ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: s8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: s28,
                child: Icon(
                  widget.icon,
                  size: s22,
                  color: _hover ? kAccentCyan : kTextSecondary,
                ),
              ),

              const SizedBox(width: s8),

              Flexible(
                child: BodyMedium(
                  widget.text,
                  color: _hover ? kAccentCyan : kTextSecondary,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
