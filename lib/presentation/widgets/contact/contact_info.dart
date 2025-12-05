// lib/presentation/widgets/contact/contact_info.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_data.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/typography.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    final canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visibilityKey: 'contact-info',
      delay: 400.ms,
      beginY: 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          SubtitleLarge(
            context.localization.contact_subtitle,
            color: kTextPrimary,
          ),

          SizedBox(height: context.adaptive(32, 48, md: 40)),

          // Contact Rows
          _ContactRow(
            icon: FontAwesomeIcons.envelope,
            text: kEmail,
            color: kAccentCyan,
            onTap: () => _open("mailto:$kEmail"),
          ),
          SizedBox(height: context.adaptive(16, 24, md: 20)),
          _ContactRow(
            icon: FontAwesomeIcons.viber,
            text: kPhoneViber,
            color: kViber,
            onTap: () => _open("viber://chat?number=$kPhoneViber"),
          ),
          SizedBox(height: context.adaptive(16, 24, md: 20)),
          _ContactRow(
            icon: FontAwesomeIcons.whatsapp,
            text: kPhoneWhatsApp,
            color: kWhatsApp,
            onTap: () => _open(
              "https://wa.me/${kPhoneWhatsApp.replaceAll('+', '').replaceAll(' ', '')}",
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
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.color ?? kAccentCyan;

    return MouseRegion(
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: 350.ms,
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: context.adaptive(20, 32, md: 28, xl: 40),
                vertical: context.adaptive(16, 20, md: 18, xl: 24),
              ),
              decoration: BoxDecoration(
                color: _hover
                    ? accent.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(context.adaptive(16, 20)),
                border: Border.all(
                  color: _hover ? accent : kWhite24,
                  width: _hover ? 1.5 : 1.0,
                ),
                boxShadow: _hover
                    ? [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  // Icon
                  FaIcon(
                    widget.icon,
                    size: context.adaptive(24, 32, md: 28, xl: 36),
                    color: _hover ? accent : kTextSecondary,
                  ),

                  SizedBox(width: context.adaptive(16, 24, md: 20)),

                  // Text
                  Expanded(
                    child:
                        BodyLarge(
                          widget.text,
                          color: _hover ? kTextPrimary : kTextSecondary,
                        ).copyWithStyle(
                          fontWeight: _hover ? semiBold : medium,
                          height: 1.4,
                        ),
                  ),

                  // Arrow
                  AnimatedRotation(
                    turns: _hover ? 0.05 : 0,
                    duration: 300.ms,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: context.adaptive(16, 22, md: 18, xl: 24),
                      color: _hover
                          ? accent
                          : kTextSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate(target: _hover ? 1 : 0)
        .scale(begin: const Offset(0.98, 0.98), curve: Curves.easeOutCubic);
  }
}
