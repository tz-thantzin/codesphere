import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';

import 'core/utils/extensions/theme_ex.dart';
import 'core/widgets/no_transitions_builder.dart';
import 'l10n/app_localizations.dart';
import 'presentation/pages/landing_page.dart';
import 'presentation/pages/not_found_page.dart';

class CodeSphereApp extends ConsumerWidget {
  const CodeSphereApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Layout(
      child: MaterialApp(
        title: 'CodeSphere',
        theme: context.theme().copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: NoTransitionsBuilder(),
              TargetPlatform.iOS: NoTransitionsBuilder(),
              TargetPlatform.linux: NoTransitionsBuilder(),
              TargetPlatform.macOS: NoTransitionsBuilder(),
              TargetPlatform.windows: NoTransitionsBuilder(),
              TargetPlatform.fuchsia: NoTransitionsBuilder(),
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          final name = (settings.name ?? '/').trim();

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
          final validSections = ['home', 'about', 'services', 'contact'];

          if (validSections.contains(hash)) {
            return MaterialPageRoute(builder: (_) => const LandingPage());
          }

          return MaterialPageRoute(builder: (_) => const NotFoundPage());
        },
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(
                mediaQuery.textScaler.scale(1.0).clamp(0.6, 1.4),
              ),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
