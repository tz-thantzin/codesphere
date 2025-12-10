import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:layout/layout.dart';

import 'core/routing/router.dart';
import 'core/utils/extensions/theme_ex.dart';
import 'core/widgets/no_transitions_builder.dart';
import 'l10n/app_localizations.dart';

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
        onGenerateRoute: AppRouter.onGenerateRoute,
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
