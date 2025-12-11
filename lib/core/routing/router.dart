import 'package:flutter/material.dart';

import '../../presentation/pages/landing_page.dart';
import '../../presentation/pages/not_found_page.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final name = (settings.name ?? '/').trim();

    // Default route
    if (name == '/' || name == '/#' || name.isEmpty) {
      return MaterialPageRoute(builder: (_) => const LandingPage());
    }

    String hash = '';

    final uri = Uri.tryParse(name);
    if (uri != null) {
      if (uri.fragment.isNotEmpty) {
        hash = uri.fragment.replaceFirst('/', '').toLowerCase();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first.startsWith('#')) {
        hash = uri.pathSegments.first
            .substring(1)
            .replaceFirst('/', '')
            .toLowerCase();
      } else if (uri.pathSegments.isNotEmpty) {
        hash = uri.pathSegments.first.toLowerCase();
      }
    }

    const validSections = ['home', 'about', 'services', 'contact'];

    if (validSections.contains(hash)) {
      return MaterialPageRoute(builder: (_) => const LandingPage());
    }

    return MaterialPageRoute(builder: (_) => const NotFoundPage());
  }
}
