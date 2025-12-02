import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';

import 'core/utils/extensions/theme_ex.dart';
import 'l10n/app_localizations.dart';
import 'presentation/pages/landing_page.dart';

class CodeSphereApp extends ConsumerWidget {
  const CodeSphereApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Layout(
      child: MaterialApp(
        title: 'CodeSphere',
        theme: context.theme(),
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LandingPage(),
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
