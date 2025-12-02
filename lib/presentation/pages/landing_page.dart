import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:web/web.dart' as web;

import '../../core/constants/constants.dart';
import '../../core/widgets/animated_background.dart';
import '../widgets/about/about_section.dart';
import '../widgets/contact/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/services_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkHash();
      web.window.addEventListener('hashchange', _handleHashChange.toJS);
    });
  }

  void _handleHashChange(web.Event _) => _checkHash();

  void _checkHash() {
    final hash = web.window.location.hash.replaceAll('/#', '');
    if (hash.isNotEmpty && sectionKeys.containsKey(hash)) {
      Future.delayed(600.ms, () => _scrollTo(hash));
    }
  }

  void _scrollTo(String section) {
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: 1200.ms,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _navigate(String section) {
    _scrollTo(section);
    web.window.history.pushState(null, '', '/#$section');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 28,
                ),
                child: Image.asset(
                  'assets/logos/codesphere_logo_text.png',
                  height: 40,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 140),
            child: Column(
              children: [
                HeroSection(
                  onViewWork: () => _navigate('services'),
                  onGetQuote: () => _navigate('contact'),
                ),
                AboutSection(key: aboutSectionKey),
                ServicesSection(key: servicesSectionKey),
                ContactSection(key: contactSectionKey),
                const SizedBox(height: 120),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
