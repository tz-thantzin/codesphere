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
import '../../../core/widgets/buttons/glowing_button.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/title_separator.dart';
import '../../../core/widgets/typography.dart';
import 'contact_info.dart';
import 'social.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.defaultPagePadding(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          AnimatedFadeSlide(
            visibilityKey: 'section-title-contact-us',
            delay: 200.ms,
            beginY: 0.2,
            child: Caption(
              '\\  ${context.localization.section_title_contact_us} \\',
              color: kWhite,
            ),
          ),

          SizedBox(height: context.adaptive(8, 12, md: 10)),

          // Main Title
          AnimatedFadeSlide(
            visibilityKey: 'contact-us-main-title',
            delay: 400.ms,
            beginY: 0.2,
            child: TitleSmall(
              context.localization.contact_us_main_title,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: context.adaptive(8, 12, md: 10)),

          // Title Separator
          AnimatedFadeSlide(
            visibilityKey: 'contact-us-title-separator',
            delay: 200.ms,
            beginY: 0.2,
            child: const TitleSeparator(),
          ),
          SizedBox(height: context.adaptive(40, 60)),

          Center(
            child: context.isMobile
                ? const _MobileLayout()
                : const _DesktopLayout(),
          ),
        ],
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();
  @override
  Widget build(BuildContext context) => Column(
    children: [
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
  Widget build(BuildContext context) => Row(
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
        CustomToast.instance.show(
          context,
          message: context.localization.contact_message_sent_successful,
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
        CustomToast.instance.show(context, message: next.error!, isError: true);
      }
    });

    return AnimatedFadeSlide(
      visibilityKey: 'contact-form',
      delay: 200.ms,
      beginY: 0.3,
      visibleFraction: 0.2,
      child: GlassCard(
        padding: EdgeInsets.all(context.adaptive(32, 56)),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField(
                context.localization.contact_your_name,
                controller: _nameController,
              ),
              SizedBox(height: context.adaptive(20, 28)),
              _buildField(
                context.localization.contact_email_address,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: context.adaptive(20, 28)),
              _buildField(
                context.localization.contact_phone_number,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: context.adaptive(20, 28)),
              _buildField(
                context.localization.contact_tell_about_prj,
                controller: _messageController,
                maxLines: 8,
              ),
              SizedBox(height: context.adaptive(36, 56)),

              GlowingButton(
                text: viewModel.isLoading
                    ? context.localization.contact_btn_sending
                    : context.localization.contact_btn_send_message,
                onPressed: viewModel.isLoading ? null : _submitForm,
                filled: true,
                padding: EdgeInsets.symmetric(
                  horizontal: context.adaptive(48, 72),
                  vertical: context.adaptive(20, 26),
                ),
                fontSize: context.adaptive(12, 16),
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
              ? context.localization.contact_warning_project_required
              : context.localization.contact_warning_field_required;
        }
        if (hint.contains("Email") &&
            !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
          return context.localization.contact_warning_enter_valid_email;
        }
        if (hint.contains("Phone") &&
            !RegExp(r'^\+?[0-9][\d\s\-()]{8,15}$').hasMatch(v)) {
          return context.localization.contact_warning_enter_valid_phone_number;
        }
        return null;
      },
    );
  }
}
