import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_data.dart';
import '../../../core/constants/constant_sizes.dart';
import '../../../core/utils/extensions/context_ex.dart';
import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/utils/extensions/text_style_ex.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/typography.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visibilityKey: 'contact-info',
      delay: 400.ms,
      beginY: 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subtitle
          SubtitleMedium(
            context.localization.contact_us_main_subtitle,
            color: kTextPrimary,
          ),

          SizedBox(height: context.adaptive(s32, s48, md: s40)),

          // Email
          _ContactRow(
            icon: FontAwesomeIcons.envelope,
            text: kEmail,
            color: kAccentCyan,
            onTap: () => _open("mailto:$kEmail"),
          ),
          SizedBox(height: context.adaptive(s16, s24, md: s20)),

          // Viber
          _ContactRow(
            icon: FontAwesomeIcons.viber,
            text: kPhoneViber,
            color: kViber,
            onTap: () =>
                _open("viber://chat?number=${kPhoneViber.replaceAll(' ', '')}"),
          ),
          SizedBox(height: context.adaptive(s16, s24, md: s20)),

          // WhatsApp
          _ContactRow(
            icon: FontAwesomeIcons.whatsapp,
            text: kPhoneWhatsApp,
            color: kWhatsApp,
            onTap: () => _open(
              "https://wa.me/${kPhoneWhatsApp.replaceAll(RegExp(r'[+\s]'), '')}",
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final VoidCallback onTap;

  const _ContactRow({
    required this.icon,
    required this.text,
    this.color,
    required this.onTap,
  });

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color accent = widget.color ?? kAccentCyan;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: 400.ms,
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: context.adaptive(s24, s40),
            vertical: context.adaptive(s18, s24),
          ),
          decoration: BoxDecoration(
            color: _isHovered
                ? accent.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(context.adaptive(s16, s20)),
            border: Border.all(
              color: _isHovered ? accent : kWhite.withValues(alpha: 0.24),
              width: _isHovered ? 1.8 : 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Icon
              FaIcon(
                widget.icon,
                size: context.adaptive(s28, s36),
                color: _isHovered ? accent : kTextSecondary,
              ),

              SizedBox(width: context.adaptive(s20, s28)),

              // Text
              Expanded(
                child:
                    BodyLarge(
                      widget.text,
                      color: _isHovered ? kTextPrimary : kTextSecondary,
                    ).copyWithStyle(
                      fontWeight: _isHovered
                          ? FontWeight.w600
                          : FontWeight.w500,
                      height: 1.5,
                    ),
              ),

              // Arrow
              AnimatedRotation(
                turns: _isHovered ? 0.08 : 0,
                duration: 350.ms,
                curve: Curves.easeOutCubic,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: context.adaptive(s18, s24),
                  color: _isHovered
                      ? accent
                      : kTextSecondary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
