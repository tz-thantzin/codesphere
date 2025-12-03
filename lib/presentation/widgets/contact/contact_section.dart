// lib/presentation/widgets/contact/contact_section.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constant_colors.dart';
import '../../../core/di/providers.dart';
import '../../../core/services/analytics_service.dart';
import '../../../core/utils/extensions/extensions.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/glowing_button.dart';
import 'contact_info.dart';
import 'social.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.adaptive(100, 200),
        horizontal: context.adaptive(20, 40),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: context.isMobile
              ? const _MobileLayout()
              : const _DesktopLayout(),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const _Title(),
      SizedBox(height: context.adaptive(60, 80)),
      const _ContactForm(),
      SizedBox(height: context.adaptive(80, 120)),
      const ContactInfo(),
      SizedBox(height: context.adaptive(60, 100)),
      const SocialRow(),
      SizedBox(height: context.adaptive(40, 80)),
    ],
  );
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const _Title(),
      SizedBox(height: context.adaptive(100, 140)),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: AnimatedFadeSlide(
              visibilityKey: 'contact-form-desktop',
              delay: 400.ms,
              beginY: 0.3,
              child: const _ContactForm(),
            ),
          ),
          SizedBox(width: context.adaptive(60, 100, xl: 140)),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ContactInfo(),
                SizedBox(height: context.adaptive(80, 120)),
                const SocialRow(),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

class _Title extends StatelessWidget {
  const _Title();
  @override
  Widget build(BuildContext context) => AnimatedFadeSlide(
    visibilityKey: 'contact-title',
    delay: 100.ms,
    beginY: 0.4,
    child: SelectableText(
      "Let’s Build Something\nExtraordinary Together",
      style: context.displayLarge.copyWith(
        fontSize: context.adaptive(36, 55),
        height: 1.05,
        fontWeight: superBold,
        color: kTextPrimary,
        shadows: [
          Shadow(
            color: kAccentCyan.withValues(alpha: 0.25),
            offset: const Offset(0, 6),
            blurRadius: 30,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    ),
  );
}

class _ContactForm extends ConsumerStatefulWidget {
  const _ContactForm();
  @override
  ConsumerState<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    unawaited(
      ref
          .read(contactViewModelProvider.notifier)
          .submitContact(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            message: _messageController.text.trim(),
          ),
    );

    AnalyticsService().logButtonClick(
      buttonName: "send_message",
      section: "contact_form",
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(contactViewModelProvider);

    ref.listen(contactViewModelProvider, (previous, next) {
      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kAccentCyan,
            content: const Text(
              "Message sent successfully! We'll contact you soon.",
              style: TextStyle(color: kWhite, fontWeight: FontWeight.w600),
            ),
            duration: const Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
          ),
        );
        _formKey.currentState?.reset();
        for (var c in [
          _nameController,
          _emailController,
          _phoneController,
          _messageController,
        ]) {
          c.clear();
        }
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade600,
            content: Text(next.error!),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return AnimatedFadeSlide(
      visibilityKey: 'contact-form',
      delay: 300.ms,
      beginY: 0.35,
      child: GlassCard(
        padding: EdgeInsets.all(context.adaptive(32, 56)),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField("Your Name", controller: _nameController),
              SizedBox(height: context.adaptive(20, 28)),
              _buildField(
                "Email Address",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: context.adaptive(20, 28)),
              _buildField(
                "Phone Number",
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: context.adaptive(20, 28)),
              _buildField(
                "Tell us about your project...",
                controller: _messageController,
                maxLines: 8,
              ),
              SizedBox(height: context.adaptive(36, 56)),

              GlowingButton(
                text: viewModel.isLoading ? "Sending..." : "Send Message",
                onPressed: viewModel.isLoading ? null : _submitForm,
                filled: true,
                padding: EdgeInsets.symmetric(
                  horizontal: context.adaptive(48, 72),
                  vertical: context.adaptive(20, 26),
                ),
                fontSize: context.adaptive(16, 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String hint, {
    TextEditingController? controller,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(
        color: kTextPrimary,
        fontSize: context.adaptive(15, 18),
        height: 1.5,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: kTextSecondary.withValues(alpha: 0.7),
          fontSize: context.adaptive(15, 17),
        ),
        filled: true,
        fillColor: kWhite.withValues(alpha: 0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.adaptive(16, 20)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.adaptive(16, 20)),
          borderSide: BorderSide(
            color: kAccentCyan.withValues(alpha: 0.6),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.adaptive(16, 20)),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.adaptive(24, 32),
          vertical: context.adaptive(20, 24),
        ),
      ),
      validator: (value) {
        final v = value?.trim();
        if (v == null || v.isEmpty) {
          return hint.contains("project")
              ? "Please tell us about your project."
              : "This field is required.";
        }
        if (hint.contains("Email") &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
          return "Please enter a valid email.";
        }
        if (hint.contains("Phone") &&
            !RegExp(r'^\+?[0-9][\d\s\-\(\)]{8,15}$').hasMatch(v)) {
          return "Please enter a valid phone number.";
        }
        return null;
      },
    );
  }
}
