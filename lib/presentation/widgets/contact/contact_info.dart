import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/constants/constant_data.dart';
import '../../../core/widgets/animated_fade_slide.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo();

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visibilityKey: 'contact-info',
      delay: 500.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            "Get in Touch",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: kTextPrimary,
            ),
          ),
          const SizedBox(height: 32),
          _ContactRow(
            icon: FontAwesomeIcons.envelope,
            text: kEmail,
            onTap: () => _open("mailto:$kEmail"),
          ),
          const SizedBox(height: 20),
          _ContactRow(
            icon: FontAwesomeIcons.viber,
            text: kPhoneViber,
            color: kViber,
            onTap: () => _open("tel:$kPhoneViber"),
          ),
          const SizedBox(height: 20),
          _ContactRow(
            icon: FontAwesomeIcons.whatsapp,
            text: kPhoneWhatsApp,
            color: kWhatsApp,
            onTap: () =>
                _open("https://wa.me/${kPhoneWhatsApp.replaceAll('+', '')}"),
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
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: 300.ms,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: _hover ? accent.withValues(alpha: 0.12) : kTransparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _hover ? accent : kWhite24),
          ),
          child: Row(
            children: [
              FaIcon(
                widget.icon,
                size: 26,
                color: _hover ? accent : kTextSecondary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SelectableText(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16,
                    color: _hover ? kTextPrimary : kTextSecondary,
                    fontWeight: _hover ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: _hover ? accent : kTextSecondary.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
