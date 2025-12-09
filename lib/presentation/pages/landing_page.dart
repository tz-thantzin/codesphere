// lib/presentation/pages/landing_page.dart
import 'dart:async';
import 'dart:js_interop';

import 'package:codesphere/core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:web/web.dart' as web;

import '../../core/constants/constants.dart';
import '../../core/services/analytics_service.dart';
import '../../core/widgets/animated_background.dart';
import '../widgets/about/about_section.dart';
import '../widgets/contact/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/navbar_section.dart';
import '../widgets/process_planning/planning_section.dart';
import '../widgets/service/our_service_section.dart';
import '../widgets/what_we_do_section/what_we_do_section.dart';

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
      _checkHashFromUrl();
      web.window.addEventListener('hashchange', _handleHashChange.toJS);
      AnalyticsService().logAppOpen();
    });
  }

  void _handleHashChange(web.Event _) => _checkHashFromUrl();

  void _checkHashFromUrl() {
    final hash = web.window.location.hash
        .replaceFirst('#/', '')
        .replaceFirst('#', '');
    final section = hash.isEmpty ? 'home' : hash;
    if (sectionKeys.containsKey(section)) {
      Future.delayed(100.ms, () => _scrollTo(section));
    }
  }

  void _scrollTo(String section) {
    Future.delayed(50.ms, () {
      if (section == 'home') {
        _scrollController.animateTo(
          0,
          duration: 1100.ms,
          curve: Curves.easeInOutCubic,
        );
        return;
      }

      final key = sectionKeys[section];
      if (key?.currentContext != null) {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: 1200.ms,
          curve: Curves.easeInOutCubic,
          alignment: 0.08,
        );
      }
    });
  }

  void _navigateTo(String section) {
    _scrollTo(section);
    web.window.history.pushState(null, '', '/#$section');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedBackground(),
          Container(
            margin: EdgeInsets.only(top: context.appBarHeight),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  HeroSection(
                    key: heroSectionKey,
                    onViewWork: () => _navigateTo('services'),
                    onGetQuote: () => _navigateTo('contact'),
                  ),
                  AboutSection(key: aboutSectionKey),
                  ProcessSection(key: planningSectionKey),
                  WhatWeDoSection(key: whatWeDoSectionKey),
                  OurServiceSection(key: servicesSectionKey),
                  ContactSection(key: contactSectionKey),
                  const Footer(),
                ],
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavbarSection(onNavigate: _navigateTo),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
