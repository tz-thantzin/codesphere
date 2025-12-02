import 'package:codesphere/core/constants/constant_colors.dart';
import 'package:codesphere/presentation/widgets/contact/contact_info.dart';
import 'package:codesphere/presentation/widgets/contact/social.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/utils/extensions/layout_adapter_ex.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/glowing_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.adaptive(120, 180),
        horizontal: 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile ? _MobileLayout() : _DesktopLayout(),
        ),
      ),
    );
  }
}

// ────────────────────── MOBILE LAYOUT ──────────────────────
class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Title(),
        const SizedBox(height: 70),
        const _ContactForm(),
        const SizedBox(height: 100),
        const ContactInfo(),
        const SizedBox(height: 80),
        const SocialRow(),
        const SizedBox(height: 40),
      ],
    );
  }
}

// ───────────────────── DESKTOP / TABLET LAYOUT ─────────────────────
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Title(),
        const SizedBox(height: 100),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form — Left Side
            Expanded(
              flex: 5,
              child: AnimatedFadeSlide(
                visibilityKey: 'contact-form-desktop',
                delay: 400.ms,
                beginY: 0.3,
                child: const _ContactForm(),
              ),
            ),
            const SizedBox(width: 80),

            // Contact Info + Social — Right Side
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContactInfo(),
                  const SizedBox(height: 80),
                  const SocialRow(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visibilityKey: 'contact-title',
      delay: 100.ms,
      beginY: 0.4,
      child: SelectableText(
        "Let’s Build Something\nExtraordinary Together",
        style: TextStyle(
          fontSize: context.adaptive(48, 82),
          height: 1.12,
          letterSpacing: -1.2,
          fontWeight: FontWeight.w900,
          color: kTextPrimary,
          shadows: [
            Shadow(
              color: kAccentCyan.withValues(alpha: 0.3),
              offset: const Offset(0, 4),
              blurRadius: 20,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm();

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      visibilityKey: 'contact-form',
      delay: 300.ms,
      beginY: 0.35,
      child: GlassCard(
        padding: const EdgeInsets.all(44),
        child: Column(
          children: [
            _buildField("Your Name"),
            const SizedBox(height: 24),
            _buildField("Email Address"),
            const SizedBox(height: 24),
            _buildField("Tell us about your project...", maxLines: 7),
            const SizedBox(height: 40),
            GlowingButton(
              text: "Send Message",
              onPressed: () {},
              filled: true,
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: kTextPrimary, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: kTextSecondary.withValues(alpha: 0.8)),
        filled: true,
        fillColor: kWhite.withValues(alpha: 0.06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: kAccentCyan.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
      ),
    );
  }
}
